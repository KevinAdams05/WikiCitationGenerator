// wiki_citation.vala
/*
 * ================================================================================================
 *  Title:        Wiki Citation Generator
 *  Description:  A application that generates Wikipedia citation markup for web sources.
 *  Author:       Kevin Adams <kevinadams05@gmail.com>
 *  Created:      2026 Apr 03
 *  License:      MIT
 * ================================================================================================
 *
 *  Change Log:
 *  -----------------------------------------------------------------------------------------------
 *  Date         Author             Description
 *  -----------------------------------------------------------------------------------------------
 *  2026 Apr 03  Kevin Adams        Initial creation
 *
 * ================================================================================================
 */

using Gtk;

public class WikiCitationWindow : Gtk.ApplicationWindow {
    private Gtk.Entry article_title_entry;
    private Gtk.Entry article_publisher_entry;
    private Gtk.Entry article_url_entry;
    private Gtk.Entry archive_url_entry;
    private Gtk.Entry access_date_entry;
    private Gtk.Entry archive_date_entry;
    private Gtk.TextView result_text_view;

    public WikiCitationWindow (Gtk.Application app) {
        Object (application: app, title: "Wiki Citation Generator", default_width: 750, default_height: 420);

        var grid = new Gtk.Grid ();
        grid.row_spacing = 8;
        grid.column_spacing = 12;
        grid.margin_start = 12;
        grid.margin_end = 12;
        grid.margin_top = 12;
        grid.margin_bottom = 12;

        int row = 0;

        // Article Title
        var article_title_label = new Gtk.Label ("Article Title:");
        article_title_label.halign = Gtk.Align.END;
        grid.attach (article_title_label, 0, row, 1, 1);
        article_title_entry = new Gtk.Entry ();
        article_title_entry.hexpand = true;
        article_title_entry.placeholder_text = "article title";
        grid.attach (article_title_entry, 1, row, 1, 1);
        row++;

        // Article Publisher
        var article_publisher_label = new Gtk.Label ("Article Publisher:");
        article_publisher_label.halign = Gtk.Align.END;
        grid.attach (article_publisher_label, 0, row, 1, 1);
        article_publisher_entry = new Gtk.Entry ();
        article_publisher_entry.hexpand = true;
        article_publisher_entry.placeholder_text = "source of the article";
        grid.attach (article_publisher_entry, 1, row, 1, 1);
        row++;

        // Article URL
        var article_url_label = new Gtk.Label ("Article URL:");
        article_url_label.halign = Gtk.Align.END;
        grid.attach (article_url_label, 0, row, 1, 1);        
        article_url_entry = new Gtk.Entry ();
        article_url_entry.hexpand = true;
        article_url_entry.placeholder_text = "this is the URL for the original source of the article";
        grid.attach (article_url_entry, 1, row, 1, 1);
        row++;

        // Archive URL
        var archive_url_label = new Gtk.Label ("Archive URL:");
        archive_url_label.halign = Gtk.Align.END;
        grid.attach (archive_url_label, 0, row, 1, 1);
        archive_url_entry = new Gtk.Entry ();
        archive_url_entry.hexpand = true;
        archive_url_entry.placeholder_text = "this is the URL for the archived version at web.archive.org";
        grid.attach (archive_url_entry, 1, row, 1, 1);
        row++;

        // access Date
        var access_date_label = new Gtk.Label ("Access Date:");
        access_date_label.halign = Gtk.Align.END;
        grid.attach (access_date_label, 0, row, 1, 1);
        access_date_entry = new Gtk.Entry ();
        access_date_entry.hexpand = true;
        access_date_entry.placeholder_text = "MMMM dd, yyyy (e.g. June 23, 2026)";
        grid.attach (access_date_entry, 1, row, 1, 1);
        row++;

        // Archive Date
        var archive_date_label = new Gtk.Label ("Archive Date:");
        archive_date_label.halign = Gtk.Align.END;
        grid.attach (archive_date_label, 0, row, 1, 1);
        archive_date_entry = new Gtk.Entry ();
        archive_date_entry.hexpand = true;
        archive_date_entry.placeholder_text = "MMMM dd, yyyy (e.g. March 27, 2026)";
        grid.attach (archive_date_entry, 1, row, 1, 1);
        row++;

        // Generate Button
        var generate_button = new Gtk.Button.with_label ("Generate");
        generate_button.halign = Gtk.Align.START;
        generate_button.clicked.connect (on_generate_clicked);
        grid.attach (generate_button, 0, row, 2, 1);

        
        // Clear Button
        var clear_button = new Gtk.Button.with_label ("Clear");
        clear_button.halign = Gtk.Align.START;
        clear_button.clicked.connect (on_clear_clicked);
        grid.attach (clear_button, 1, row, 2, 1);
        row++;

        // Result TextView in a ScrolledWindow
        var scrolled = new Gtk.ScrolledWindow ();
        scrolled.vexpand = true;
        scrolled.hexpand = true;
        scrolled.min_content_height = 100;
        result_text_view = new Gtk.TextView ();
        result_text_view.wrap_mode = Gtk.WrapMode.WORD_CHAR;
        result_text_view.editable = true;
        scrolled.child = result_text_view;
        grid.attach (scrolled, 0, row, 2, 1);

        this.child = grid;
    }

    private void on_generate_clicked () {
        string title = article_title_entry.text;
        string publisher = article_publisher_entry.text;
        string url = article_url_entry.text;
        string archive_url = archive_url_entry.text;
        string access_date = access_date_entry.text;
        string archive_date = archive_date_entry.text;

        string result = "<ref>{{cite web|title=%s".printf (title)
            + "|url=%s".printf (url)
            + "|publisher=%s".printf (publisher)
            + "|access-date=%s".printf (access_date)
            + "|archive-date=%s".printf (archive_date)
            + "|archive-url=%s".printf (archive_url)
            + "|url-status=live}}</ref>";

        result_text_view.buffer.text = result;
    }
    
    private void on_clear_clicked () {
        article_title_entry.text = "";
        article_publisher_entry.text = "";
        article_url_entry.text = "";
        archive_url_entry.text = "";
        access_date_entry.text = "";
        archive_date_entry.text = "";
        result_text_view.buffer.text = "";
    }    
}

public class WikiCitationApp : Gtk.Application {
    public WikiCitationApp () {
        Object (application_id: "kadams.wikicitation", flags: ApplicationFlags.DEFAULT_FLAGS);
    }

    protected override void activate () {
        var win = new WikiCitationWindow (this);
        win.present ();
    }
}

int main (string[] args) {
    var app = new WikiCitationApp ();
    return app.run (args);
}

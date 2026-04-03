OUTPUT_DIR=Output
TARGET=$(OUTPUT_DIR)/wiki_citation
SRC=wiki_citation.vala

all: $(TARGET)

$(TARGET): $(SRC)
	mkdir -p $(OUTPUT_DIR)
	valac --pkg gtk4 $(SRC) -o $(TARGET)

clean:
	rm -rf $(OUTPUT_DIR)

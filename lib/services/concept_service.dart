import '../model/concept.dart';

class ConceptApiService {
  Future<List<ConceptItem>> fetchConcepts() async {
    // Simulate API delay, just like a real network call
    await Future.delayed(const Duration(seconds: 2));

    // This is your "API response" - replace with actual data fetched from your Node.js backend
    return [
      ConceptItem(
        header: "What does 29035F iconography means?",
        image: "https://tinyurl.com/m68mej2r",
        body:
            "This is the detailed explanation for 29035F iconography. It delves into the symbolic representations and visual language used within the application, helping users understand the meanings behind various icons and visual elements. This ensures a consistent and intuitive user experience.",
      ),
      ConceptItem(
        header: "Science Across Civilizations and Centuries",
        image: "",
        body:
            "Explore the fascinating journey of scientific discovery from ancient civilizations to modern times. This section covers key breakthroughs, influential figures, and the evolution of scientific thought across different cultures and historical periods.",
      ),
      ConceptItem(
        header: "Introduction to Realms",
        image: "https://tinyurl.com/m68mej2r",
        body:
            "Discover the concept of 'Realms' within our system. Each realm represents a unique domain or area of knowledge, allowing for organized exploration and deeper understanding of specific topics. Learn how to navigate and interact with various realms.",
      ),
      ConceptItem(
        header: "Introduction to Energies",
        image: "",
        body:
            "Understand the fundamental principles of 'Energies' as they apply to our platform. This module explains different types of energies, their interactions, and how they influence various processes and outcomes within the application's ecosystem.",
      ),
      ConceptItem(
        header: "Introduction to Habits",
        image: "https://tinyurl.com/m68mej2r",
        body:
            "Learn about the power of habits and how to cultivate positive ones within the context of this application. This section provides insights into habit formation, tracking, and strategies for building sustainable routines to achieve your goals.",
      ),
    ];
  }
}

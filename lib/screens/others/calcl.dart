Map<String, double> calculatePercentage<T>(List<T> items, String statusKey) {
  int total = items.length;
  if (total == 0) return {'En cours': 0, 'Finalisée': 0, 'En attente': 0};

  int enCoursCount = items.where((item) => (item as dynamic).status == 'En cours').length;
  int finaliseeCount = items.where((item) => (item as dynamic).status == 'Finalisée').length;
  int enAttenteCount = items.where((item) => (item as dynamic).status == 'En attente').length;

  return {
    'En cours': enCoursCount / total,
    'Finalisée': finaliseeCount / total,
    'En attente': enAttenteCount / total,
  };
}

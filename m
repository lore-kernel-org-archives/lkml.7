Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD37C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F3F20675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iaQ4x5j9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfEWJfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:35:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59879 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbfEWJfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:35:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9Yohl4043259
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:34:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9Yohl4043259
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558604091;
        bh=OXyI8lFCU0lZh/JsoD6JxMsFTP0z/SPSIfK0fymgw6g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iaQ4x5j9u48q1R9Kpy8dBlAy+MWPv3wgM9cWqiv5hqONi2/CIJeevqnVMQsV+SVqZ
         Vae2a17QzeZCdoP8pHRw9xKHyxHNsa9q3yBLOOeYQ2fQBuBHCnZBMl/xoCb7ae+R2R
         0g7xYKEawwliLUZgMmMomLQCRo6OzYtJJr+LlyEGIO3KRAzDTIxm7CPm8fyg5IgzAO
         PkxzxJjAkeCmwTlRSZkfu9hnRy37iXaPSdMkfAJlZ1nS0p5CZ4RXgPyODveCJH8VJh
         t+stP3J9SO6vC3Baz+LzOfVNsl77xiuVDIiEkSKrgX/EDKrIRPlhnBReKQ9/NVZ1fU
         7WyRuUBdoajrA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9YoxM4043256;
        Thu, 23 May 2019 02:34:50 -0700
Date:   Thu, 23 May 2019 02:34:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-b0529b9cafacfd054837ea6b8c4ef7b402716744@git.kernel.org>
Cc:     hpa@zytor.com, len.brown@intel.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, len.brown@intel.com, kan.liang@linux.intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <f0ea5e501288329135e94f51969ff54a03c50e2e.1557769318.git.len.brown@intel.com>
References: <f0ea5e501288329135e94f51969ff54a03c50e2e.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] perf/x86/intel/uncore: Cosmetic renames in
 response to multi-die/pkg support
Git-Commit-ID: b0529b9cafacfd054837ea6b8c4ef7b402716744
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b0529b9cafacfd054837ea6b8c4ef7b402716744
Gitweb:     https://git.kernel.org/tip/b0529b9cafacfd054837ea6b8c4ef7b402716744
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 13 May 2019 13:59:02 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:36 +0200

perf/x86/intel/uncore: Cosmetic renames in response to multi-die/pkg support

Syntax update only -- no logical or functional change.

In response to the new multi-die/package changes, update variable names to
use "die" terminology, instead of "pkg".

For previous platforms which doesn't have multi-die, "die" is identical as
"pkg".

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/f0ea5e501288329135e94f51969ff54a03c50e2e.1557769318.git.len.brown@intel.com

---
 arch/x86/events/intel/uncore.c       | 74 ++++++++++++++++++------------------
 arch/x86/events/intel/uncore.h       |  4 +-
 arch/x86/events/intel/uncore_snbep.c |  4 +-
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index aeb5eae83750..f943e4d0e66c 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -14,7 +14,7 @@ struct pci_driver *uncore_pci_driver;
 DEFINE_RAW_SPINLOCK(pci2phy_map_lock);
 struct list_head pci2phy_map_head = LIST_HEAD_INIT(pci2phy_map_head);
 struct pci_extra_dev *uncore_extra_pci_dev;
-static int max_packages;
+static int max_dies;
 
 /* mask of cpus that collect uncore events */
 static cpumask_t uncore_cpu_mask;
@@ -100,13 +100,13 @@ ssize_t uncore_event_show(struct kobject *kobj,
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
 {
-	unsigned int pkgid = topology_logical_die_id(cpu);
+	unsigned int dieid = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return pkgid < max_packages ? pmu->boxes[pkgid] : NULL;
+	return dieid < max_dies ? pmu->boxes[dieid] : NULL;
 }
 
 u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *event)
@@ -311,7 +311,7 @@ static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
 	uncore_pmu_init_hrtimer(box);
 	box->cpu = -1;
 	box->pci_phys_id = -1;
-	box->pkgid = -1;
+	box->dieid = -1;
 
 	/* set default hrtimer timeout */
 	box->hrtimer_duration = UNCORE_PMU_HRTIMER_INTERVAL;
@@ -826,10 +826,10 @@ static void uncore_pmu_unregister(struct intel_uncore_pmu *pmu)
 
 static void uncore_free_boxes(struct intel_uncore_pmu *pmu)
 {
-	int pkg;
+	int die;
 
-	for (pkg = 0; pkg < max_packages; pkg++)
-		kfree(pmu->boxes[pkg]);
+	for (die = 0; die < max_dies; die++)
+		kfree(pmu->boxes[die]);
 	kfree(pmu->boxes);
 }
 
@@ -866,7 +866,7 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 	if (!pmus)
 		return -ENOMEM;
 
-	size = max_packages * sizeof(struct intel_uncore_box *);
+	size = max_dies * sizeof(struct intel_uncore_box *);
 
 	for (i = 0; i < type->num_boxes; i++) {
 		pmus[i].func_id	= setid ? i : -1;
@@ -936,21 +936,21 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu = NULL;
 	struct intel_uncore_box *box;
-	int phys_id, pkg, ret;
+	int phys_id, die, ret;
 
 	phys_id = uncore_pcibus_to_physid(pdev->bus);
 	if (phys_id < 0)
 		return -ENODEV;
 
-	pkg = (topology_max_die_per_package() > 1) ? phys_id :
+	die = (topology_max_die_per_package() > 1) ? phys_id :
 					topology_phys_to_logical_pkg(phys_id);
-	if (pkg < 0)
+	if (die < 0)
 		return -EINVAL;
 
 	if (UNCORE_PCI_DEV_TYPE(id->driver_data) == UNCORE_EXTRA_PCI_DEV) {
 		int idx = UNCORE_PCI_DEV_IDX(id->driver_data);
 
-		uncore_extra_pci_dev[pkg].dev[idx] = pdev;
+		uncore_extra_pci_dev[die].dev[idx] = pdev;
 		pci_set_drvdata(pdev, NULL);
 		return 0;
 	}
@@ -989,7 +989,7 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		pmu = &type->pmus[UNCORE_PCI_DEV_IDX(id->driver_data)];
 	}
 
-	if (WARN_ON_ONCE(pmu->boxes[pkg] != NULL))
+	if (WARN_ON_ONCE(pmu->boxes[die] != NULL))
 		return -EINVAL;
 
 	box = uncore_alloc_box(type, NUMA_NO_NODE);
@@ -1003,13 +1003,13 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	atomic_inc(&box->refcnt);
 	box->pci_phys_id = phys_id;
-	box->pkgid = pkg;
+	box->dieid = die;
 	box->pci_dev = pdev;
 	box->pmu = pmu;
 	uncore_box_init(box);
 	pci_set_drvdata(pdev, box);
 
-	pmu->boxes[pkg] = box;
+	pmu->boxes[die] = box;
 	if (atomic_inc_return(&pmu->activeboxes) > 1)
 		return 0;
 
@@ -1017,7 +1017,7 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	ret = uncore_pmu_register(pmu);
 	if (ret) {
 		pci_set_drvdata(pdev, NULL);
-		pmu->boxes[pkg] = NULL;
+		pmu->boxes[die] = NULL;
 		uncore_box_exit(box);
 		kfree(box);
 	}
@@ -1028,17 +1028,17 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 {
 	struct intel_uncore_box *box;
 	struct intel_uncore_pmu *pmu;
-	int i, phys_id, pkg;
+	int i, phys_id, die;
 
 	phys_id = uncore_pcibus_to_physid(pdev->bus);
 
 	box = pci_get_drvdata(pdev);
 	if (!box) {
-		pkg = (topology_max_die_per_package() > 1) ? phys_id :
+		die = (topology_max_die_per_package() > 1) ? phys_id :
 					topology_phys_to_logical_pkg(phys_id);
 		for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
-			if (uncore_extra_pci_dev[pkg].dev[i] == pdev) {
-				uncore_extra_pci_dev[pkg].dev[i] = NULL;
+			if (uncore_extra_pci_dev[die].dev[i] == pdev) {
+				uncore_extra_pci_dev[die].dev[i] = NULL;
 				break;
 			}
 		}
@@ -1051,7 +1051,7 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 		return;
 
 	pci_set_drvdata(pdev, NULL);
-	pmu->boxes[box->pkgid] = NULL;
+	pmu->boxes[box->dieid] = NULL;
 	if (atomic_dec_return(&pmu->activeboxes) == 0)
 		uncore_pmu_unregister(pmu);
 	uncore_box_exit(box);
@@ -1063,7 +1063,7 @@ static int __init uncore_pci_init(void)
 	size_t size;
 	int ret;
 
-	size = max_packages * sizeof(struct pci_extra_dev);
+	size = max_dies * sizeof(struct pci_extra_dev);
 	uncore_extra_pci_dev = kzalloc(size, GFP_KERNEL);
 	if (!uncore_extra_pci_dev) {
 		ret = -ENOMEM;
@@ -1110,11 +1110,11 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
 {
 	struct intel_uncore_pmu *pmu = type->pmus;
 	struct intel_uncore_box *box;
-	int i, pkg;
+	int i, die;
 
-	pkg = topology_logical_die_id(old_cpu < 0 ? new_cpu : old_cpu);
+	die = topology_logical_die_id(old_cpu < 0 ? new_cpu : old_cpu);
 	for (i = 0; i < type->num_boxes; i++, pmu++) {
-		box = pmu->boxes[pkg];
+		box = pmu->boxes[die];
 		if (!box)
 			continue;
 
@@ -1147,7 +1147,7 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 	struct intel_uncore_type *type, **types = uncore_msr_uncores;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, pkg, target;
+	int i, die, target;
 
 	/* Check if exiting cpu is used for collecting uncore events */
 	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
@@ -1166,12 +1166,12 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 
 unref:
 	/* Clear the references */
-	pkg = topology_logical_die_id(cpu);
+	die = topology_logical_die_id(cpu);
 	for (; *types; types++) {
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[pkg];
+			box = pmu->boxes[die];
 			if (box && atomic_dec_return(&box->refcnt) == 0)
 				uncore_box_exit(box);
 		}
@@ -1180,7 +1180,7 @@ unref:
 }
 
 static int allocate_boxes(struct intel_uncore_type **types,
-			 unsigned int pkg, unsigned int cpu)
+			 unsigned int die, unsigned int cpu)
 {
 	struct intel_uncore_box *box, *tmp;
 	struct intel_uncore_type *type;
@@ -1193,20 +1193,20 @@ static int allocate_boxes(struct intel_uncore_type **types,
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			if (pmu->boxes[pkg])
+			if (pmu->boxes[die])
 				continue;
 			box = uncore_alloc_box(type, cpu_to_node(cpu));
 			if (!box)
 				goto cleanup;
 			box->pmu = pmu;
-			box->pkgid = pkg;
+			box->dieid = die;
 			list_add(&box->active_list, &allocated);
 		}
 	}
 	/* Install them in the pmus */
 	list_for_each_entry_safe(box, tmp, &allocated, active_list) {
 		list_del_init(&box->active_list);
-		box->pmu->boxes[pkg] = box;
+		box->pmu->boxes[die] = box;
 	}
 	return 0;
 
@@ -1223,10 +1223,10 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	struct intel_uncore_type *type, **types = uncore_msr_uncores;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, ret, pkg, target;
+	int i, ret, die, target;
 
-	pkg = topology_logical_die_id(cpu);
-	ret = allocate_boxes(types, pkg, cpu);
+	die = topology_logical_die_id(cpu);
+	ret = allocate_boxes(types, die, cpu);
 	if (ret)
 		return ret;
 
@@ -1234,7 +1234,7 @@ static int uncore_event_cpu_online(unsigned int cpu)
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[pkg];
+			box = pmu->boxes[die];
 			if (box && atomic_inc_return(&box->refcnt) == 1)
 				uncore_box_init(box);
 		}
@@ -1419,7 +1419,7 @@ static int __init intel_uncore_init(void)
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return -ENODEV;
 
-	max_packages = topology_max_packages() * topology_max_die_per_package();
+	max_dies = topology_max_packages() * topology_max_die_per_package();
 
 	uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
 	if (uncore_init->pci_init) {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 79eb2e21e4f0..33aba2504cb1 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -108,7 +108,7 @@ struct intel_uncore_extra_reg {
 
 struct intel_uncore_box {
 	int pci_phys_id;
-	int pkgid;	/* Logical package ID */
+	int dieid;	/* Logical die ID */
 	int n_active;	/* number of active events */
 	int n_events;
 	int cpu;	/* cpu to collect events */
@@ -467,7 +467,7 @@ static inline void uncore_box_exit(struct intel_uncore_box *box)
 
 static inline bool uncore_box_is_fake(struct intel_uncore_box *box)
 {
-	return (box->pkgid < 0);
+	return (box->dieid < 0);
 }
 
 static inline struct intel_uncore_pmu *uncore_event_to_pmu(struct perf_event *event)
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b10e04387f38..bbe89bc589f9 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1058,8 +1058,8 @@ static void snbep_qpi_enable_event(struct intel_uncore_box *box, struct perf_eve
 
 	if (reg1->idx != EXTRA_REG_NONE) {
 		int idx = box->pmu->pmu_idx + SNBEP_PCI_QPI_PORT0_FILTER;
-		int pkg = box->pkgid;
-		struct pci_dev *filter_pdev = uncore_extra_pci_dev[pkg].dev[idx];
+		int die = box->dieid;
+		struct pci_dev *filter_pdev = uncore_extra_pci_dev[die].dev[idx];
 
 		if (filter_pdev) {
 			pci_write_config_dword(filter_pdev, reg1->reg,

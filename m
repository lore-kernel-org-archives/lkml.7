Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1036C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654D82087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553538859;
	bh=WxHIZ+yAIqoBZNJ3rKUoqcPyPA2YrsRFvv9zQuWLBDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Zd03Xlin3URNOo2dAlJWZdT9sZDLSHCf5vow4Bt0I8Zu/yfpf2eyMm6DzCvei3LD
	 KnhoY4bxehfc+94px2pB9Gc+Sq5UfvOhZoVPOTRPr8DZSHt6JPR9QatvVmeA1fwvnm
	 VAO0iEFMzJwrVDaJq8QmqHMlmpOkauv0zoqWS184=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfCYSeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbfCYSeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:34:16 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFCA92087C;
        Mon, 25 Mar 2019 18:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553538855;
        bh=WxHIZ+yAIqoBZNJ3rKUoqcPyPA2YrsRFvv9zQuWLBDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tM6E8YNIiLWUjLhesw2YybQMJVSbX0YzxBHw76YsHttrxpC02jxA2hgZuu1A3txzG
         kPKG0iRibrHghYHLf/huVNkoemwZs/8RxEHv8rX8p7oaUVYrWa4iGrdTGeP8LrRxq1
         MLGNujFAc1WPKdD6x0FZLbBdgffXbwr2RDYQ/biU=
From:   helgaas@kernel.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/4] ACPI: Fix comment typos
Date:   Mon, 25 Mar 2019 13:34:00 -0500
Message-Id: <20190325183403.251473-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325183403.251473-1-helgaas@kernel.org>
References: <20190325183403.251473-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix some misspellings in comments.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/acpi_dbg.c     |  2 +-
 drivers/acpi/acpi_lpat.c    |  2 +-
 drivers/acpi/cppc_acpi.c    | 34 +++++++++++++-------------
 drivers/acpi/power.c        |  4 ++--
 drivers/acpi/pptt.c         | 48 ++++++++++++++++++-------------------
 drivers/acpi/scan.c         |  2 +-
 drivers/acpi/spcr.c         |  2 +-
 drivers/acpi/video_detect.c |  2 +-
 8 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index 4a434c23a196..d18246a2a65e 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -390,7 +390,7 @@ static ssize_t acpi_aml_read_cmd(char *msg, size_t count)
 	return size > 0 ? size : ret;
 }
 
-static int acpi_aml_thread(void *unsed)
+static int acpi_aml_thread(void *unused)
 {
 	acpi_osd_exec_callback function = NULL;
 	void *context;
diff --git a/drivers/acpi/acpi_lpat.c b/drivers/acpi/acpi_lpat.c
index 2cd9f738812b..43f1b99c86ca 100644
--- a/drivers/acpi/acpi_lpat.c
+++ b/drivers/acpi/acpi_lpat.c
@@ -22,7 +22,7 @@
  * LPAT conversion table
  *
  * @lpat_table: the temperature_raw mapping table structure
- * @raw: the raw value, used as a key to get the temerature from the
+ * @raw: the raw value, used as a key to get the temperature from the
  *       above mapping table
  *
  * A positive converted temperature value will be returned on success,
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1b207fca1420..e947a1ec82f9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -81,9 +81,9 @@ struct cppc_pcc_data {
 	int refcount;
 };
 
-/* Array  to represent the PCC channel per subspace id */
+/* Array to represent the PCC channel per subspace ID */
 static struct cppc_pcc_data *pcc_data[MAX_PCC_SUBSPACES];
-/* The cpu_pcc_subspace_idx containsper CPU subspace id */
+/* The cpu_pcc_subspace_idx contains per CPU subspace ID */
 static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
 
 /*
@@ -436,7 +436,7 @@ int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
 		return -ENOMEM;
 
 	/*
-	 * Now that we have _PSD data from all CPUs, lets setup P-state
+	 * Now that we have _PSD data from all CPUs, let's setup P-state
 	 * domain info.
 	 */
 	for_each_possible_cpu(i) {
@@ -588,7 +588,7 @@ static int register_pcc_channel(int pcc_ss_idx)
 			return -ENOMEM;
 		}
 
-		/* Set flag so that we dont come here for each CPU. */
+		/* Set flag so that we don't come here for each CPU. */
 		pcc_data[pcc_ss_idx]->pcc_channel_acquired = true;
 	}
 
@@ -613,7 +613,7 @@ bool __weak cpc_ffh_supported(void)
  *
  * Check and allocate the cppc_pcc_data memory.
  * In some processor configurations it is possible that same subspace
- * is shared between multiple CPU's. This is seen especially in CPU's
+ * is shared between multiple CPUs. This is seen especially in CPUs
  * with hardware multi-threading support.
  *
  * Return: 0 for success, errno for failure
@@ -711,7 +711,7 @@ static bool is_cppc_supported(int revision, int num_ent)
 
 /**
  * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
- * @pr: Ptr to acpi_processor containing this CPUs logical Id.
+ * @pr: Ptr to acpi_processor containing this CPU's logical ID.
  *
  *	Return: 0 for success or negative value for err.
  */
@@ -728,7 +728,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	acpi_status status;
 	int ret = -EFAULT;
 
-	/* Parse the ACPI _CPC table for this cpu. */
+	/* Parse the ACPI _CPC table for this CPU. */
 	status = acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
 			ACPI_TYPE_PACKAGE);
 	if (ACPI_FAILURE(status)) {
@@ -840,7 +840,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	if (ret)
 		goto out_free;
 
-	/* Register PCC channel once for all PCC subspace id. */
+	/* Register PCC channel once for all PCC subspace ID. */
 	if (pcc_subspace_id >= 0 && !pcc_data[pcc_subspace_id]->pcc_channel_acquired) {
 		ret = register_pcc_channel(pcc_subspace_id);
 		if (ret)
@@ -860,7 +860,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		goto out_free;
 	}
 
-	/* Plug PSD data into this CPUs CPC descriptor. */
+	/* Plug PSD data into this CPU's CPC descriptor. */
 	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
 
 	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
@@ -891,7 +891,7 @@ EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
 
 /**
  * acpi_cppc_processor_exit - Cleanup CPC structs.
- * @pr: Ptr to acpi_processor containing this CPUs logical Id.
+ * @pr: Ptr to acpi_processor containing this CPU's logical ID.
  *
  * Return: Void
  */
@@ -931,7 +931,7 @@ EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
 
 /**
  * cpc_read_ffh() - Read FFH register
- * @cpunum:	cpu number to read
+ * @cpunum:	CPU number to read
  * @reg:	cppc register information
  * @val:	place holder for return value
  *
@@ -946,7 +946,7 @@ int __weak cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
 
 /**
  * cpc_write_ffh() - Write FFH register
- * @cpunum:	cpu number to write
+ * @cpunum:	CPU number to write
  * @reg:	cppc register information
  * @val:	value to write
  *
@@ -1093,7 +1093,7 @@ int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
 
 /**
- * cppc_get_perf_caps - Get a CPUs performance capabilities.
+ * cppc_get_perf_caps - Get a CPU's performance capabilities.
  * @cpunum: CPU from which to get capabilities info.
  * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
  *
@@ -1178,7 +1178,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
 
 /**
- * cppc_get_perf_ctrs - Read a CPUs performance feedback counters.
+ * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
  * @cpunum: CPU from which to read counters.
  * @perf_fb_ctrs: ptr to cppc_perf_fb_ctrs. See cppc_acpi.h
  *
@@ -1205,7 +1205,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	ctr_wrap_reg = &cpc_desc->cpc_regs[CTR_WRAP_TIME];
 
 	/*
-	 * If refernce perf register is not supported then we should
+	 * If reference perf register is not supported then we should
 	 * use the nominal perf value
 	 */
 	if (!CPC_SUPPORTED(ref_perf_reg))
@@ -1258,7 +1258,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
 
 /**
- * cppc_set_perf - Set a CPUs performance controls.
+ * cppc_set_perf - Set a CPU's performance controls.
  * @cpu: CPU for which to set performance controls.
  * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
  *
@@ -1339,7 +1339,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * executing the Phase-II.
 	 *     2. Some other CPU has beaten this CPU to successfully execute the
 	 * write_trylock and has already acquired the write_lock. We know for a
-	 * fact it(other CPU acquiring the write_lock) couldn't have happened
+	 * fact it (other CPU acquiring the write_lock) couldn't have happened
 	 * before this CPU's Phase-I as we held the read_lock.
 	 *     3. Some other CPU executing pcc CMD_READ has stolen the
 	 * down_write, in which case, send_pcc_cmd will check for pending
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 665e93ca0b40..87db3e124725 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -535,12 +535,12 @@ int acpi_device_sleep_wake(struct acpi_device *dev,
 	/*
 	 * Try to execute _DSW first.
 	 *
-	 * Three agruments are needed for the _DSW object:
+	 * Three arguments are needed for the _DSW object:
 	 * Argument 0: enable/disable the wake capabilities
 	 * Argument 1: target system state
 	 * Argument 2: target device state
 	 * When _DSW object is called to disable the wake capabilities, maybe
-	 * the first argument is filled. The values of the other two agruments
+	 * the first argument is filled. The values of the other two arguments
 	 * are meaningless.
 	 */
 	in_arg[0].type = ACPI_TYPE_INTEGER;
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 065c4fc245d1..b72e6afaa8fb 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -164,7 +164,7 @@ static struct acpi_pptt_cache *acpi_find_cache_level(struct acpi_table_header *t
 }
 
 /**
- * acpi_count_levels() - Given a PPTT table, and a cpu node, count the caches
+ * acpi_count_levels() - Given a PPTT table, and a CPU node, count the caches
  * @table_hdr: Pointer to the head of the PPTT table
  * @cpu_node: processor node we wish to count caches for
  *
@@ -235,7 +235,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 /**
  * acpi_find_processor_node() - Given a PPTT table find the requested processor
  * @table_hdr:  Pointer to the head of the PPTT table
- * @acpi_cpu_id: cpu we are searching for
+ * @acpi_cpu_id: CPU we are searching for
  *
  * Find the subtable entry describing the provided processor.
  * This is done by iterating the PPTT table looking for processor nodes
@@ -456,21 +456,21 @@ static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_ta
 
 static void acpi_pptt_warn_missing(void)
 {
-	pr_warn_once("No PPTT table found, cpu and cache topology may be inaccurate\n");
+	pr_warn_once("No PPTT table found, CPU and cache topology may be inaccurate\n");
 }
 
 /**
  * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
  * @table: Pointer to the head of the PPTT table
- * @cpu: Kernel logical cpu number
+ * @cpu: Kernel logical CPU number
  * @level: A level that terminates the search
  * @flag: A flag which terminates the search
  *
- * Get a unique value given a cpu, and a topology level, that can be
+ * Get a unique value given a CPU, and a topology level, that can be
  * matched to determine which cpus share common topological features
  * at that level.
  *
- * Return: Unique value, or -ENOENT if unable to locate cpu
+ * Return: Unique value, or -ENOENT if unable to locate CPU
  */
 static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 				     unsigned int cpu, int level, int flag)
@@ -510,7 +510,7 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 		return -ENOENT;
 	}
 	retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
-	pr_debug("Topology Setup ACPI cpu %d, level %d ret = %d\n",
+	pr_debug("Topology Setup ACPI CPU %d, level %d ret = %d\n",
 		 cpu, level, retval);
 	acpi_put_table(table);
 
@@ -519,9 +519,9 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 
 /**
  * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
- * @cpu: Kernel logical cpu number
+ * @cpu: Kernel logical CPU number
  *
- * Given a logical cpu number, returns the number of levels of cache represented
+ * Given a logical CPU number, returns the number of levels of cache represented
  * in the PPTT. Errors caused by lack of a PPTT table, or otherwise, return 0
  * indicating we didn't find any cache levels.
  *
@@ -534,7 +534,7 @@ int acpi_find_last_cache_level(unsigned int cpu)
 	int number_of_levels = 0;
 	acpi_status status;
 
-	pr_debug("Cache Setup find last level cpu=%d\n", cpu);
+	pr_debug("Cache Setup find last level CPU=%d\n", cpu);
 
 	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
 	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
@@ -551,14 +551,14 @@ int acpi_find_last_cache_level(unsigned int cpu)
 
 /**
  * cache_setup_acpi() - Override CPU cache topology with data from the PPTT
- * @cpu: Kernel logical cpu number
+ * @cpu: Kernel logical CPU number
  *
  * Updates the global cache info provided by cpu_get_cacheinfo()
  * when there are valid properties in the acpi_pptt_cache nodes. A
  * successful parse may not result in any updates if none of the
- * cache levels have any valid flags set.  Futher, a unique value is
+ * cache levels have any valid flags set.  Further, a unique value is
  * associated with each known CPU cache entry. This unique value
- * can be used to determine whether caches are shared between cpus.
+ * can be used to determine whether caches are shared between CPUs.
  *
  * Return: -ENOENT on failure to find table, or 0 on success
  */
@@ -567,7 +567,7 @@ int cache_setup_acpi(unsigned int cpu)
 	struct acpi_table_header *table;
 	acpi_status status;
 
-	pr_debug("Cache Setup ACPI cpu %d\n", cpu);
+	pr_debug("Cache Setup ACPI CPU %d\n", cpu);
 
 	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
 	if (ACPI_FAILURE(status)) {
@@ -582,8 +582,8 @@ int cache_setup_acpi(unsigned int cpu)
 }
 
 /**
- * find_acpi_cpu_topology() - Determine a unique topology value for a given cpu
- * @cpu: Kernel logical cpu number
+ * find_acpi_cpu_topology() - Determine a unique topology value for a given CPU
+ * @cpu: Kernel logical CPU number
  * @level: The topological level for which we would like a unique ID
  *
  * Determine a topology unique ID for each thread/core/cluster/mc_grouping
@@ -596,7 +596,7 @@ int cache_setup_acpi(unsigned int cpu)
  * other levels beyond this use a generated value to uniquely identify
  * a topological feature.
  *
- * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
+ * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
  * Otherwise returns a value which represents a unique topological feature.
  */
 int find_acpi_cpu_topology(unsigned int cpu, int level)
@@ -606,12 +606,12 @@ int find_acpi_cpu_topology(unsigned int cpu, int level)
 
 /**
  * find_acpi_cpu_cache_topology() - Determine a unique cache topology value
- * @cpu: Kernel logical cpu number
+ * @cpu: Kernel logical CPU number
  * @level: The cache level for which we would like a unique ID
  *
  * Determine a unique ID for each unified cache in the system
  *
- * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
+ * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
  * Otherwise returns a value which represents a unique topological feature.
  */
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
@@ -643,17 +643,17 @@ int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 
 
 /**
- * find_acpi_cpu_topology_package() - Determine a unique cpu package value
- * @cpu: Kernel logical cpu number
+ * find_acpi_cpu_topology_package() - Determine a unique CPU package value
+ * @cpu: Kernel logical CPU number
  *
- * Determine a topology unique package ID for the given cpu.
+ * Determine a topology unique package ID for the given CPU.
  * This ID can then be used to group peers, which will have matching ids.
  *
  * The search terminates when either a level is found with the PHYSICAL_PACKAGE
  * flag set or we reach a root node.
  *
- * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
- * Otherwise returns a value which represents the package for this cpu.
+ * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
+ * Otherwise returns a value which represents the package for this CPU.
  */
 int find_acpi_cpu_topology_package(unsigned int cpu)
 {
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 446c959a8f08..1b66fc835e39 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -895,7 +895,7 @@ static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 	/*
 	 * Call _PSW/_DSW object to disable its ability to wake the sleeping
 	 * system for the ACPI device with the _PRW object.
-	 * The _PSW object is depreciated in ACPI 3.0 and is replaced by _DSW.
+	 * The _PSW object is deprecated in ACPI 3.0 and is replaced by _DSW.
 	 * So it is necessary to call _DSW object first. Only when it is not
 	 * present will the _PSW object used.
 	 */
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index c336784d0bcb..b34d05e365b7 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -28,7 +28,7 @@ EXPORT_SYMBOL(qdf2400_e44_present);
 
 /*
  * Some Qualcomm Datacenter Technologies SoCs have a defective UART BUSY bit.
- * Detect them by examining the OEM fields in the SPCR header, similiar to PCI
+ * Detect them by examining the OEM fields in the SPCR header, similar to PCI
  * quirk detection in pci_mcfg.c.
  */
 static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 43587ac680e4..cc2888930fe9 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -112,7 +112,7 @@ static int video_detect_force_none(const struct dmi_system_id *d)
 static const struct dmi_system_id video_detect_dmi_table[] = {
 	/* On Samsung X360, the BIOS will set a flag (VDRV) if generic
 	 * ACPI backlight device is used. This flag will definitively break
-	 * the backlight interface (even the vendor interface) untill next
+	 * the backlight interface (even the vendor interface) until next
 	 * reboot. It's why we should prevent video.ko from being used here
 	 * and we can't rely on a later call to acpi_video_unregister().
 	 */
-- 
2.21.0.392.gf8f6787159e-goog


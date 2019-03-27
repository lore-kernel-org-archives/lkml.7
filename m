Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDB4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647CB2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfC0T5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:57:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727117AbfC0T5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:57:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RJnmEL168464
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:57:30 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rgfkt8ff7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:57:30 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Mar 2019 19:57:29 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Mar 2019 19:57:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2RJvQHr6684904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 19:57:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5751FB2064;
        Wed, 27 Mar 2019 19:57:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B3B9B2066;
        Wed, 27 Mar 2019 19:57:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Mar 2019 19:57:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3915416C35A4; Wed, 27 Mar 2019 12:57:26 -0700 (PDT)
Date:   Wed, 27 Mar 2019 12:57:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.03.20b 54/83]
 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: error: type
 defaults to 'int' in declaration of 'DEFINE_SRCU'
Reply-To: paulmck@linux.ibm.com
References: <201903250225.RRMwkT3f%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201903250225.RRMwkT3f%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032719-0040-0000-0000-000004D82888
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010825; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180545; UDB=6.00606765; IPR=6.00961263;
 MB=3.00026183; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-27 19:57:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032719-0041-0000-0000-000008E34A81
Message-Id: <20190327195726.GF4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 02:34:27AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.03.20b
> head:   6d4434b4b4df791620743178e1419de882b44c7b
> commit: eb89abcb30733e3a2343dda23cb6d81cc17c60b3 [54/83] rcu: Forbid DEFINE{,_STATIC}_SRCU() from modules
> config: x86_64-randconfig-b0-03250021 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout eb89abcb30733e3a2343dda23cb6d81cc17c60b3
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: warning: data definition has no type or storage class
>     DEFINE_SRCU(kfd_processes_srcu);
>     ^~~~~~~~~~~
> >> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: error: type defaults to 'int' in declaration of 'DEFINE_SRCU' [-Werror=implicit-int]
>    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: warning: parameter names (without types) in function declaration
>    cc1: some warnings being treated as errors

I don't have that hardware, but does the following help?  (It at least
builds for me, but your mileage may vary.)

							Thanx, Paul

------------------------------------------------------------------------

commit b30be5a76070402912437fa23b43de11cb1973f4
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Wed Mar 27 12:53:36 2019 -0700

    drivers/gpu/drm/amd: Dynamically allocate kfd_processes_srcu
    
    Having DEFINE_SRCU() or DEFINE_STATIC_SRCU() in a loadable module
    requires that the size of the reserved region be increased, which is
    not something we really want to be doing.  This commit therefore removes
    the DEFINE_STATIC_SRCU() from drivers/gpu/drm/amd/amdkfd/kfd_process.c in
    favor of defining kfd_processes_srcu as a simple srcu_struct, initializing
    it in amdgpu_amdkfd_init(), and cleaning it up in amdgpu_amdkfd_fini().
    
    Reported-by: kbuild test robot <lkp@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
    Cc: Oded Gabbay <oded.gabbay@gmail.com>
    Cc: Alex Deucher <alexander.deucher@amd.com>
    Cc: "Christian König" <christian.koenig@amd.com
    Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
    Cc: David Airlie <airlied@linux.ie>
    Cc: Daniel Vetter <daniel@ffwll.ch>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index fe1d7368c1e6..eadb20dee867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -28,6 +28,8 @@
 #include <linux/module.h>
 #include <linux/dma-buf.h>
 
+extern struct srcu_struct kfd_processes_srcu;
+
 static const unsigned int compute_vmid_bitmap = 0xFF00;
 
 /* Total memory size in system memory and all GPU VRAM. Used to
@@ -40,6 +42,8 @@ int amdgpu_amdkfd_init(void)
 	struct sysinfo si;
 	int ret;
 
+	ret = init_srcu_struct(&kfd_processes_srcu);
+	WARN_ON(ret);
 	si_meminfo(&si);
 	amdgpu_amdkfd_total_mem_size = si.totalram - si.totalhigh;
 	amdgpu_amdkfd_total_mem_size *= si.mem_unit;
@@ -57,6 +61,7 @@ int amdgpu_amdkfd_init(void)
 void amdgpu_amdkfd_fini(void)
 {
 	kgd2kfd_exit();
+	cleanup_srcu_struct(&kfd_processes_srcu);
 }
 
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 4bdae78bab8e..98b694068b8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -47,7 +47,7 @@ struct mm_struct;
 DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 static DEFINE_MUTEX(kfd_processes_mutex);
 
-DEFINE_SRCU(kfd_processes_srcu);
+struct srcu_struct kfd_processes_srcu;
 
 /* For process termination handling */
 static struct workqueue_struct *kfd_process_wq;


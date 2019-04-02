Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9091C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BBB20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfDBNE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:04:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbfDBNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:04:27 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32Cx7wg075644
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 09:04:26 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rm6t55nwy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:04:24 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 2 Apr 2019 14:04:23 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 14:04:20 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32D4JSh17170682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 13:04:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6176B206E;
        Tue,  2 Apr 2019 13:04:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B24D8B2067;
        Tue,  2 Apr 2019 13:04:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 13:04:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AEFF816C3449; Tue,  2 Apr 2019 06:04:24 -0700 (PDT)
Date:   Tue, 2 Apr 2019 06:04:24 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.03.20b 54/83]
 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: error: type
 defaults to 'int' in declaration of 'DEFINE_SRCU'
Reply-To: paulmck@linux.ibm.com
References: <201903250225.RRMwkT3f%lkp@intel.com>
 <20190327195726.GF4102@linux.ibm.com>
 <cad8bc52-a3ab-0d4e-bb13-c436510f684b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cad8bc52-a3ab-0d4e-bb13-c436510f684b@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040213-0064-0000-0000-000003C564AF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010860; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183256; UDB=6.00619461; IPR=6.00964004;
 MB=3.00026260; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 13:04:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040213-0065-0000-0000-00003CEC3E00
Message-Id: <20190402130424.GU4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:32:45AM +0800, Rong Chen wrote:
> 
> On 3/28/19 3:57 AM, Paul E. McKenney wrote:
> >On Mon, Mar 25, 2019 at 02:34:27AM +0800, kbuild test robot wrote:
> >>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.03.20b
> >>head:   6d4434b4b4df791620743178e1419de882b44c7b
> >>commit: eb89abcb30733e3a2343dda23cb6d81cc17c60b3 [54/83] rcu: Forbid DEFINE{,_STATIC}_SRCU() from modules
> >>config: x86_64-randconfig-b0-03250021 (attached as .config)
> >>compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> >>reproduce:
> >>         git checkout eb89abcb30733e3a2343dda23cb6d81cc17c60b3
> >>         # save the attached .config to linux build tree
> >>         make ARCH=x86_64
> >>
> >>All errors (new ones prefixed by >>):
> >>
> >>    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: warning: data definition has no type or storage class
> >>     DEFINE_SRCU(kfd_processes_srcu);
> >>     ^~~~~~~~~~~
> >>>>drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: error: type defaults to 'int' in declaration of 'DEFINE_SRCU' [-Werror=implicit-int]
> >>    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: warning: parameter names (without types) in function declaration
> >>    cc1: some warnings being treated as errors
> >I don't have that hardware, but does the following help?  (It at least
> >builds for me, but your mileage may vary.)
> 
> Yes, the patch works for kbuild robot.

Thank you very much!  May I add your Tested-by?

							Thanx, Paul

> Thanks,
> Rong Chen
> 
> 
> >
> >------------------------------------------------------------------------
> >
> >commit b30be5a76070402912437fa23b43de11cb1973f4
> >Author: Paul E. McKenney <paulmck@linux.ibm.com>
> >Date:   Wed Mar 27 12:53:36 2019 -0700
> >
> >     drivers/gpu/drm/amd: Dynamically allocate kfd_processes_srcu
> >     Having DEFINE_SRCU() or DEFINE_STATIC_SRCU() in a loadable module
> >     requires that the size of the reserved region be increased, which is
> >     not something we really want to be doing.  This commit therefore removes
> >     the DEFINE_STATIC_SRCU() from drivers/gpu/drm/amd/amdkfd/kfd_process.c in
> >     favor of defining kfd_processes_srcu as a simple srcu_struct, initializing
> >     it in amdgpu_amdkfd_init(), and cleaning it up in amdgpu_amdkfd_fini().
> >     Reported-by: kbuild test robot <lkp@intel.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> >     Cc: Oded Gabbay <oded.gabbay@gmail.com>
> >     Cc: Alex Deucher <alexander.deucher@amd.com>
> >     Cc: "Christian König" <christian.koenig@amd.com
> >     Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> >     Cc: David Airlie <airlied@linux.ie>
> >     Cc: Daniel Vetter <daniel@ffwll.ch>
> >
> >diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >index fe1d7368c1e6..eadb20dee867 100644
> >--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >@@ -28,6 +28,8 @@
> >  #include <linux/module.h>
> >  #include <linux/dma-buf.h>
> >+extern struct srcu_struct kfd_processes_srcu;
> >+
> >  static const unsigned int compute_vmid_bitmap = 0xFF00;
> >  /* Total memory size in system memory and all GPU VRAM. Used to
> >@@ -40,6 +42,8 @@ int amdgpu_amdkfd_init(void)
> >  	struct sysinfo si;
> >  	int ret;
> >+	ret = init_srcu_struct(&kfd_processes_srcu);
> >+	WARN_ON(ret);
> >  	si_meminfo(&si);
> >  	amdgpu_amdkfd_total_mem_size = si.totalram - si.totalhigh;
> >  	amdgpu_amdkfd_total_mem_size *= si.mem_unit;
> >@@ -57,6 +61,7 @@ int amdgpu_amdkfd_init(void)
> >  void amdgpu_amdkfd_fini(void)
> >  {
> >  	kgd2kfd_exit();
> >+	cleanup_srcu_struct(&kfd_processes_srcu);
> >  }
> >  void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
> >diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> >index 4bdae78bab8e..98b694068b8a 100644
> >--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> >+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> >@@ -47,7 +47,7 @@ struct mm_struct;
> >  DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
> >  static DEFINE_MUTEX(kfd_processes_mutex);
> >-DEFINE_SRCU(kfd_processes_srcu);
> >+struct srcu_struct kfd_processes_srcu;
> >  /* For process termination handling */
> >  static struct workqueue_struct *kfd_process_wq;
> >
> 


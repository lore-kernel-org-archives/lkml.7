Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680C121841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1QhQu1tE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCVUZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:25:57 -0400
Received: from mail-eopbgr710060.outbound.protection.outlook.com ([40.107.71.60]:42304
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfCVUZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+jF9sZ3OrxgksiSqowfC2ac0F78zO07fH/namHe2MU=;
 b=1QhQu1tEOUbYs2sayUTqAzC/8BnsAXeiBjfkDE45ipmoeFTAlX/HdqcGkEWC2Ut2tiUDg0neqzCUfvnkTm1hdFjuOUyMSGPgW2sCvfhQnX1zA7amEVPLxmgKYvPOWW2LXcqjSKc8LvtCPTzahTB0ezqP+Imf7XVFENnI8ip0knY=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2687.namprd12.prod.outlook.com (52.135.103.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 20:25:53 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 20:25:53 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 0/6] CPPC optional registers AMD support
Thread-Topic: [PATCH 0/6] CPPC optional registers AMD support
Thread-Index: AQHU4O1yJJA21XiyakyCX+9FoVbplw==
Date:   Fri, 22 Mar 2019 20:25:53 +0000
Message-ID: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 950142b4-3168-4c4f-b45c-08d6af0494d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2687;
x-ms-traffictypediagnostic: SN6PR12MB2687:
x-microsoft-antispam-prvs: <SN6PR12MB2687682F22C51F862AD3A4C4E7430@SN6PR12MB2687.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(136003)(376002)(189003)(199004)(7736002)(71190400001)(5660300002)(14454004)(71200400001)(478600001)(6436002)(72206003)(2616005)(476003)(305945005)(97736004)(68736007)(2501003)(6486002)(14444005)(256004)(105586002)(486006)(54906003)(53936002)(110136005)(81166006)(2906002)(81156014)(25786009)(99286004)(6512007)(106356001)(8936002)(36756003)(50226002)(102836004)(4326008)(26005)(6116002)(2201001)(6506007)(66066001)(3846002)(316002)(386003)(86362001)(52116002)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yjJLnPwRo+AzMjpY9/WkVUpztlv1lJ3EOYW/ntUnEb2oPb27loth1LZbNCwlvq7nbVHo3aTSk4uSZC+8lQgrm+zZVINvV2IaCKW+/FJOR6gJfvOFIaKY8FdOOsDxmiMqnEgipvVOZgcdPQ2LO38hIkimrVGPvgh5KWWVHI9091//VZdcgBouDYUGqi2YT9RonSbUCHzqoa1y0YI/0+nFO6u7nrNO+0vyBqG+AsFgMIoU9b/Cl3AszQXRaYnGhpTnVyh8Cq3cWdNnnpESUi4iB8fbKF1bcqJcJS5o6Tcc0h4fW4O6Hkpwdru2mOc3/aLYL8UzUq3iS0KReqT1eM86x0Kcl51ZKyPn/fjvart/KpIEkjWY7/FDHq/RcNs2cjjFQHBeIrT5wz2jPqkEPMEcJ6MIXAYIdxyR1bnMrJL+WOc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950142b4-3168-4c4f-b45c-08d6af0494d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:25:53.5744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPPC (Collaborative Processor Performance Control) offers optional
registers which can be used to tune the system based on energy and/or
performance requirements.

Newer AMD processors add support for a subset of these optional CPPC
registers, based on ACPI v6.1.

The following are the supported CPPC registers for which sysfs entries
are created:
* enable		(NEW)
* max_perf		(NEW)
* min_perf		(NEW)
* energy_perf
* lowest_perf
* nominal_perf
* desired_perf		(NEW)
* feedback_ctrs
* auto_sel_enable	(NEW)
* lowest_nonlinear_perf

The CPPC driver is updated to enable the OSPM and the userspace to access
the newly supported registers.

The purpose of exposing the registers via the sysfs entries is to allow
the userspace to:
* Tweak the values to fit its workload.
* Apply a profile from AMD's optimization guides.

Profiles will be documented in the performance/optimization guides.

Note:
* AMD systems will not have a policy applied in the kernel at this time.
* By default, acpi_cpufreq will still be used.

TODO:
* Create a linux userspace tool that will help users generate a CPPC profil=
e
  for their target workload.
* Create or update a driver to apply a general CPPC policy in the kernel.

Janakarajan Natarajan (1):
  acpi/cppc: Ensure only supported CPPC sysfs entries are created

Yazen Ghannam (5):
  acpi/cppc: Modify show_cppc_data macro
  acpi/cppc: Rework cppc_set_perf() to use cppc_regs index
  acpi/cppc: Add macros to define a R/W sysfs entry for CPPC registers
  acpi/cppc: Add support for optional CPPC registers
  acpi/cppc: Add support for CPPC Enable register

 drivers/acpi/cppc_acpi.c       | 363 +++++++++++++++++++++++++++++----
 drivers/cpufreq/cppc_cpufreq.c |   6 +-
 include/acpi/cppc_acpi.h       |   6 +-
 3 files changed, 333 insertions(+), 42 deletions(-)

--=20
2.17.1


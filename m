Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F123C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AF121721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HcVkLamg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGBPXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:23:19 -0400
Received: from mail-eopbgr710063.outbound.protection.outlook.com ([40.107.71.63]:53714
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbfGBPXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h75yvrwLtjfX9Ib3/+yo1edpkHA0lUSqN60VkZMYSaQ=;
 b=HcVkLamgrMP/FgPjamfcwjPg1Ng68nwrmbvGCSx1HrrtgbO+sThirNz7v19yvV7rVE5mm4N54fTFum7GToa9JD36R/sVAqtGaaKuMeNuN4GRfOG7VHTN7USi/duwGDCpzqZUqRr+M+HfX6itW6fW9GVA0XbSnmpBwknDQRrA+FM=
Received: from CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) by
 CY4PR12MB1159.namprd12.prod.outlook.com (10.168.163.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 15:23:15 +0000
Received: from CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::a1e9:d665:b7a3:87e3]) by CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::a1e9:d665:b7a3:87e3%6]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 15:23:15 +0000
From:   "Phillips, Kim" <kim.phillips@amd.com>
To:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sandipan@linux.ibm.com" <sandipan@linux.ibm.com>,
        "mpetlan@redhat.com" <mpetlan@redhat.com>,
        "kim.phillips@arm.com" <kim.phillips@arm.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] .mailmap: update Kim Phillips' email address
Thread-Topic: [PATCH] .mailmap: update Kim Phillips' email address
Thread-Index: AQHVMOoRhPJCSrvLREWmDZcUrxC7OQ==
Date:   Tue, 2 Jul 2019 15:23:15 +0000
Message-ID: <20190702152306.17003-1-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM3PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:0:54::23) To CY4PR12MB1798.namprd12.prod.outlook.com
 (2603:10b6:903:11a::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 326073b9-fb56-45c4-9bce-08d6ff01340f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR12MB1159;
x-ms-traffictypediagnostic: CY4PR12MB1159:
x-microsoft-antispam-prvs: <CY4PR12MB11595FC1702DC8D282583DE387F80@CY4PR12MB1159.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:226;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(81166006)(256004)(4744005)(81156014)(2201001)(1076003)(7736002)(8676002)(6506007)(6116002)(186003)(53936002)(52116002)(6486002)(2616005)(102836004)(6512007)(6436002)(73956011)(86362001)(2906002)(26005)(386003)(8936002)(3846002)(305945005)(478600001)(2501003)(316002)(486006)(71200400001)(66946007)(68736007)(25786009)(66476007)(66556008)(64756008)(66446008)(71190400001)(110136005)(14454004)(476003)(5660300002)(99286004)(66066001)(36756003)(50226002)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1159;H:CY4PR12MB1798.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: afNIEAk4scvJBPheb7wiRajlqcvecfugDQfKcKm0vqeE9LhMDczzFZxD27utzxJGsvRD7ZllV4RR8Y91eAsJc6X6MbHWN99IAANtqMUZSdpOYhp6hHNSZBATprPnhV/RM2SEaX23Yjo9ejLffoNbT+saadEqU87mTdmR3AK7KnK4ke+bUPlDyMTOSn9/wdEc25umP34GFkKfyRbQicGLKXYbC2B3XmZ0zUYIamcuRSm2Myu+PSS6wz+ij+LSzdLZMAwWSQhdgGpLqLCLlTF1a+O24CX3yocEkPvKKyVGRWAIUuam4AQRJHsLDAkc1rmrSRS7Tn4K7bjmclAJnrRkwwvEJJLRNCxqh/wO8GX7ln0h2ahGQxZP4BV4FTWwI93ZY1XeX0Im85HOeJ7CurKK0rNrN4qipPO4uo//GlY2vP0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42CFA011A638C94FB4218205A9FD4EB8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326073b9-fb56-45c4-9bce-08d6ff01340f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 15:23:15.7315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kphillips@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

Patches are being sent with my old arm.com email address on Cc:.
This'll help them actually reach my new inbox.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 0fef932de3db..c1fb8dff5ee5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -118,6 +118,7 @@ Juha Yrjola <juha.yrjola@nokia.com>
 Juha Yrjola <juha.yrjola@solidboot.com>
 Kay Sievers <kay.sievers@vrfy.org>
 Kenneth W Chen <kenneth.w.chen@intel.com>
+Kim Phillips <kim.phillips@amd.com> <kim.phillips@arm.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
 Koushik <raghavendra.koushik@neterion.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
--=20
2.22.0


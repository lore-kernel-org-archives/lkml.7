Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD207C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851CC20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfDHUmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:42:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:3277 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfDHUmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:42:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 13:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="149120793"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 13:42:37 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 8 Apr 2019 13:42:37 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.183]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.50]) with mapi id 14.03.0415.000;
 Mon, 8 Apr 2019 13:42:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
Thread-Topic: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
Thread-Index: AQHU7hUSYTqXxdHZ3kOiah7oXgcNraYytquAgAB3c4D//4vHYA==
Date:   Mon, 8 Apr 2019 20:42:36 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7E8F6A61@ORSMSX104.amr.corp.intel.com>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-5-Yazen.Ghannam@amd.com>
 <20190408202659.GA5232@agluck-desk> <20190408203431.GM15689@zn.tnic>
In-Reply-To: <20190408203431.GM15689@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmEzODM5YzYtZDRlMi00NmUwLWJhY2UtODI3MDhiYzBjODllIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiM3FcLzV2eFFoRmFac3pyYlNRR2ozdnAxNnNZZHJFNDdyRlJHOHROZFhGZUYyakZxZWhBRkl2U1hWNHpob25kbHMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBY3R1YWxseSwgaXQgc2hvdWxkIG5vdCBiZSBleHBvcnRlZCBhdCBhbGwuIEEgZnVuY3Rpb24g
cmV0dXJuaW5nIHRoZSBudW0NCj4gYmFua3MgaXMgYmV0dGVyIGluc3RlYWQuDQoNCkFyZSBhbGwg
dGhlIHBsYWNlcyBpdCBpcyB1c2VkIGluIG5vbi1wcmUtZW1wdGlibGUgc2VjdGlvbnMgb2YgY29k
ZT8gTG9vcGluZw0KaW4gdGhlIENNQ0kgYW5kICNNQyBoYW5kbGVycyBzaG91bGQgYmUgZmluZS4g
QnV0IGRvIHdlIG5lZWQgZ2V0X2NwdSgpL3B1dF9jcHUoKQ0KaW4gYW55IHBsYWNlcz8NCg0KLVRv
bnkNCg==

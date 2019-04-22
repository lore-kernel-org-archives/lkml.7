Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6BBC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9063120859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfDVP7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:59:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:5590 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfDVP7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:59:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 08:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,382,1549958400"; 
   d="scan'208";a="136374592"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2019 08:59:17 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 22 Apr 2019 08:59:16 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.183]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.110]) with mapi id 14.03.0415.000;
 Mon, 22 Apr 2019 08:59:16 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Thread-Topic: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Thread-Index: AQHU9jKBC6KJVSji90+B+N/k56qJIaZC+16AgAAKogD//5VvgIAAe1WAgAB/EwCAAa2HAIADF7EQ
Date:   Mon, 22 Apr 2019 15:59:16 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7E90A404@ORSMSX104.amr.corp.intel.com>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic> <20190419000745.GA12291@agluck-desk>
 <20190419002911.GB559@zn.tnic> <20190419150400.GA12738@agluck-desk>
 <20190420094120.GB29704@zn.tnic>
In-Reply-To: <20190420094120.GB29704@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjJiMDE1OTctYmZlNi00MjQ4LTgzMzItMzVjOTc4NmZkYTBlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUW9QcFlHSlZTMXpKdWVjUXhEMFdGdmo5UVBvTHZienZjMnVpSnFSaFwvdjZZa00zUXYzSkJCOHZBeldNaEd4V1wvIn0=
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

PiBFcnIsIHRoaXMgYWxsIHNvdW5kcyB0byBtZSBsaWtlIHRoZSBzdG9ybSBkZXRlY3Rpb24gY29k
ZSBzaG91bGQNCj4gKmF1dG9tYXRpY2FsbHkqIGRpc2FibGUgdGhlIENFQyBpbiBzdWNoIGNhc2Vz
LCBJJ2Qgc2F5Lg0KDQpTb3VuZHMgZ29vZC4gQnV0IHdlIHNob3VsZCBkaXN0aW5ndWlzaCBzdG9y
bXMgdGhhdCBoYXZlIG1hbnkgZGlmZmVyZW50DQphZGRyZXNzZXMgZnJvbSBzdG9ybXMgdGhhdCBq
dXN0IHBpbmcgYSBmZXcgYWRkcmVzc2VzLiAgQ0VDIHdpbGwgc2VlIGNvdW50cw0KaGl0IHRoZSB0
aHJlc2hvbGQgaW4gdGhlIGxhdHRlciBjYXNlLCBidXQgaXQgbWlnaHQgbm90IGJlIGFibGUgdG8g
dGFrZSB0aGUgcGFnZXMNCm9mZmxpbmUgKGJlY2F1c2UgdGhleSBhcmUgbG9ja2VkLCBvciBpbi11
c2UgYnkga2VybmVsKS4NCg0KU28gSSB0aGluayB0aGUgY2hhbmdlIG1pZ2h0IGJlIHRvIHRoZSBy
ZXR1cm4gdmFsdWUgZnJvbSBOT1RJRllfU1RPUCB0byBOT1RJRllfRE9ORQ0KLi4uIGJ1dCBvbmx5
IGlmIHdlIGFyZSBpbiB0aGUgbWlkZGxlIG9mIGEgc3Rvcm0gQU5EIHRoZSBDRUMgYXJyYXkgaXMg
ZnVsbC4NCg0KLVRvbnkNCg0K

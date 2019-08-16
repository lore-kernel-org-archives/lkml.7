Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336CC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A418721721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfHPQ3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:29:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:13719 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfHPQ3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:29:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 09:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,393,1559545200"; 
   d="scan'208";a="328727153"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2019 09:29:19 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 16 Aug 2019 09:29:19 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.6]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.75]) with mapi id 14.03.0439.000;
 Fri, 16 Aug 2019 09:29:19 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Thread-Topic: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Thread-Index: AQHVUvmohFuCfK9scUWSgr8NyWrQpqb8TdAAgAAoIICAAH6MgP//lLaAgACUa4D//7MogIAA+0WAgAAs4VA=
Date:   Fri, 16 Aug 2019 16:29:19 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F42410E@ORSMSX115.amr.corp.intel.com>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
 <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
 <20190815175455.GJ15313@zn.tnic>
 <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de>
 <20190815224704.GA10025@agluck-desk2.amr.corp.intel.com>
 <20190816064625.GD18980@zn.tnic>
In-Reply-To: <20190816064625.GD18980@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmM2MjdiMTctZjZmNi00ZDAxLWE5ZmItMzRmNDBiYjUzYTc3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN0h2Tkk4d3JjbU1tSFlPOTBWZzlRSytoa0ZkZW9sTkxhR1wvaWZuU3hOVDlrdjJ3eTdxdmErbDgrelZXQjJZYzgifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKyAqIFRoZSBkZWZpbmVkIHN5bWJvbCBuYW1lcyBoYXZlIHRoZSBmb2xsb3dpbmcgZm9ybToN
Cj4+ICsgKglJTlRFTF9GQU02e09QVEZBTUlMWX1fe01JQ1JPQVJDSH17T1BURElGRn0NCj4NCj4g
SSB0aGluayB5b3Ugd2FudCB0byBoYXZlIHRoZSB1bmRlcnNjb3JlcyBpbiB0aGUgdGVtcGxhdGU6
DQo+DQo+CUlOVEVMX0ZBTTZfe09QVEZBTUlMWX1fe01JQ1JPQVJDSH1fe09QVERJRkZ9DQo+DQo+
IGJ1dCBubyBuZWVkIHRvIHJlc2VuZCBpZiB0aGlzIGlzIHRoZSBvbmx5IGlzc3VlIC0gSSdsbCBm
aXggaXQgdXAgd2hlbg0KPiBhcHBseWluZy4NCg0KSSBzdGFydGVkIHRoZXJlLCBidXQgdGhlbiBo
YWQgdG8gaW5jbHVkZSBhIHNlbnRlbmNlIHNheWluZyB0byBza2lwIHRoZSAiXyINCmlmIHlvdSBk
aWRuJ3QgaW5jbHVkZSBlaXRoZXIvYm90aCBvZiB0aGUgb3B0aW9uYWwgZmllbGRzLg0KDQotVG9u
eQ0K

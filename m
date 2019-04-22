Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144AFC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4984214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfDVQ3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:29:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:61021 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfDVQ3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:29:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 09:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,382,1549958400"; 
   d="scan'208";a="136382525"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2019 09:29:35 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 22 Apr 2019 09:29:35 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.183]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.68]) with mapi id 14.03.0415.000;
 Mon, 22 Apr 2019 09:29:35 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Cong Wang <xiyou.wangcong@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Thread-Topic: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Thread-Index: AQHU9jKBC6KJVSji90+B+N/k56qJIaZC+16AgAAKogCAAAgoAIAAB+6AgAHqtYCAADq4gIAAmG0AgAAIIQCAAofRkA==
Date:   Mon, 22 Apr 2019 16:29:35 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7E90A49F@ORSMSX104.amr.corp.intel.com>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
 <20190419002645.GA559@zn.tnic>
 <CAM_iQpVk564gCu_FBKvYVQjA1hGZ4YXB6ogrSFt=qZwiWen2tw@mail.gmail.com>
 <20190420091313.GA29704@zn.tnic>
 <CAM_iQpUaBOS92u7K+hzzRX5hw0Kbrp-0o0DSfLwSGBhenntVjA@mail.gmail.com>
 <20190420184751.GE29704@zn.tnic>
In-Reply-To: <20190420184751.GE29704@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTJkNWNlZDMtZGVkMS00MGU4LWFlZmYtMTM5MTY3YmY2NTQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYVpXNENDYkRDWG9JV3pXOVlSUEpIWnFKUWVDczQxRFRGXC91U0szRGlkXC9xVlVBczlQalN3a2h4azlXRFhHVlFlIn0=
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

PiBOb3csIGlmIHlvdSBzdGlsbCB3YW50IHRvIGtub3cgaG93IG1hbnkgZXJyb3JzIGFuZCB3aGVy
ZSB0aGV5IGhhcHBlbmVkDQo+IGFuZCB3aGVuIHRoZXkgaGFwcGVuZWQgYW5kIHlhZGRhIHlhZGRh
LCB5b3UgKmRpc2FibGUqIHRoZSBDRUMuDQoNClJlYm9vdGluZyBpc24ndCBwb3B1bGFyIGluIG1h
bnkgZW5kIHVzZXIgc2l0dWF0aW9ucy4gTWFueSBDU1AgKGNsb3VkDQpzZXJ2aWNlIHByb3ZpZGVy
cykgdmVoZW1lbnRseSBoYXRlIHRoZSBpZGVhIG9mIHJlYm9vdGluZy4NCg0KLVRvbnkNCg==

Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3380DC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F8021019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437114AbfIJRaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:30:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:52936 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732925AbfIJRaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:30:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 10:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; 
   d="scan'208";a="184239176"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2019 10:30:10 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 10 Sep 2019 10:30:10 -0700
Received: from orsmsx113.amr.corp.intel.com ([169.254.9.198]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.98]) with mapi id 14.03.0439.000;
 Tue, 10 Sep 2019 10:30:10 -0700
From:   "Mehta, Sohil" <sohil.mehta@intel.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "Park, Kyung Min" <kyung.min.park@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Lu, Baolu" <baolu.lu@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Add Scalable Mode fault information
Thread-Topic: [PATCH] iommu/vt-d: Add Scalable Mode fault information
Thread-Index: AQHVZN/HQgvpmNXZLUqG3t3JDwxWUaclCW2AgACd4YA=
Date:   Tue, 10 Sep 2019 17:30:09 +0000
Message-ID: <1568136807.58430.11.camel@intel.com>
References: <1567793642-17063-1-git-send-email-kyung.min.park@intel.com>
         <20190910080823.GA3247@8bytes.org>
In-Reply-To: <20190910080823.GA3247@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.110.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFD19441763DE043B6380832CA51AC62@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTEwIGF0IDEwOjA4ICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
ID4gK8KgwqDCoMKgwqAiVW5rbm93biIsICJVbmtub3duIiwgIlVua25vd24iLCAiVW5rbm93biIs
ICJVbmtub3duIiwNCj4gIlVua25vd24iLCAiVW5rbm93biIsIC8qIDB4NDktMHg0RiAqLw0KPiAN
Cj4gTWF5YmUgYWRkIHRoZSBudW1iZXIgKDB4NDktMHg0ZikgdG8gdGhlIHJlc3BlY3RpbmcgIlVu
a25vd24iIGZpZWxkcz8NCj4gSWYNCj4gd2UgY2FuJ3QgZ2l2ZSBhIHJlYXNvbiB3ZSBzaG91bGQg
Z2l2ZSB0aGUgbnVtYmVyIGZvciBlYXNpZXIgZGVidWdnaW5nDQo+IGluDQo+IHRoZSBmdXR1cmUu
IFNhbWUgZm9yIHRoZSAiVW5rbm93biIgZmllbGRzIGJlbG93Lg0KDQpJIGJlbGlldmUgYSBmYXVs
dCBudW1iZXIgaXMgYWx3YXlzIHByaW50ZWQgaW7CoGRtYXJfZmF1bHRfZG9fb25lKCkgZXZlbg0K
aWYgdGhlIHJlYXNvbiBpcyB1bmtub3duLg0KDQpETUFSOiBbRE1BIFdyaXRlXSBSZXF1ZXN0IGRl
dmljZSBbMDA6MDIuMF0gZmF1bHQgYWRkciAxMDhhMDAwIFtmYXVsdA0KcmVhc29uIDIzXSBVbmtu
b3duDQoNCi0tU29oaWwNCg==

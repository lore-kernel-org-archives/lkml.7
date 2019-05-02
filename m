Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31D6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FC720644
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEBW3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:29:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:30482 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfEBW3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:29:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 15:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,423,1549958400"; 
   d="scan'208";a="342955072"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga006.fm.intel.com with ESMTP; 02 May 2019 15:29:35 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 2 May 2019 15:29:35 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.30]) by
 FMSMSX119.amr.corp.intel.com ([169.254.14.214]) with mapi id 14.03.0415.000;
 Thu, 2 May 2019 15:29:35 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "sashal@kernel.org" <sashal@kernel.org>, "bp@suse.de" <bp@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "david@redhat.com" <david@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>
Subject: Re: [v5 0/3] "Hotremove" persistent memory
Thread-Topic: [v5 0/3] "Hotremove" persistent memory
Thread-Index: AQHVARb3UO0Lxl+oRESN1JIk0+ExN6ZYxIMAgAAO+YCAAAy2gA==
Date:   Thu, 2 May 2019 22:29:34 +0000
Message-ID: <9bf70d80718d014601361f07813b68e20b089201.camel@intel.com>
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
         <76dfe7943f2a0ceaca73f5fd23e944dfdc0309d1.camel@intel.com>
         <CA+CK2bA=E4zRFb0Qky=baOQi_LF4x4eu8KVdEkhPJo3wWr8dYQ@mail.gmail.com>
In-Reply-To: <CA+CK2bA=E4zRFb0Qky=baOQi_LF4x4eu8KVdEkhPJo3wWr8dYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <93582F626602AA429B5A803F8F5CDACA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTAyIGF0IDE3OjQ0IC0wNDAwLCBQYXZlbCBUYXRhc2hpbiB3cm90ZToN
Cg0KPiA+IEluIHJ1bm5pbmcgd2l0aCB0aGVzZSBwYXRjaGVzLCBhbmQgdGVzdGluZyB0aGUgb2Zm
bGluaW5nIHBhcnQsIEkgcmFuDQo+ID4gaW50byB0aGUgZm9sbG93aW5nIGxvY2tkZXAgYmVsb3cu
DQo+ID4gDQo+ID4gVGhpcyBpcyB3aXRoIGp1c3QgdGhlc2UgdGhyZWUgcGF0Y2hlcyBvbiB0b3Ag
b2YgLXJjNy4NCj4gDQo+IEhpIFZlcm1hLA0KPiANCj4gVGhhbmsgeW91IGZvciB0ZXN0aW5nLiBJ
IHdvbmRlciBpZiB0aGVyZSBpcyBhIGNvbW1hbmQgc2VxdWVuY2UgdGhhdCBJDQo+IGNvdWxkIHJ1
biB0byByZXByb2R1Y2UgaXQ/DQo+IEFsc28sIGNvdWxkIHlvdSBwbGVhc2Ugc2VuZCB5b3VyIGNv
bmZpZyBhbmQgcWVtdSBhcmd1bWVudHMuDQo+IA0KWWVzLCBoZXJlIGlzIHRoZSBxZW11IGNvbmZp
ZzoNCg0KcWVtdS1zeXN0ZW0teDg2XzY0DQoJLW1hY2hpbmUgYWNjZWw9a3ZtDQoJLW1hY2hpbmUg
cGMtaTQ0MGZ4LTIuNixhY2NlbD1rdm0sdXNiPW9mZix2bXBvcnQ9b2ZmLGR1bXAtZ3Vlc3QtY29y
ZT1vZmYsbnZkaW1tDQoJLWNwdSBIYXN3ZWxsLW5vVFNYDQoJLW0gMTJHLHNsb3RzPTMsbWF4bWVt
PTQ0Rw0KCS1yZWFsdGltZSBtbG9jaz1vZmYNCgktc21wIDgsc29ja2V0cz0yLGNvcmVzPTQsdGhy
ZWFkcz0xDQoJLW51bWEgbm9kZSxub2RlaWQ9MCxjcHVzPTAtMyxtZW09NkcNCgktbnVtYSBub2Rl
LG5vZGVpZD0xLGNwdXM9NC03LG1lbT02Rw0KCS1udW1hIG5vZGUsbm9kZWlkPTINCgktbnVtYSBu
b2RlLG5vZGVpZD0zDQoJLWRyaXZlIGZpbGU9L3ZpcnQvZmVkb3JhLXRlc3QucWNvdzIsZm9ybWF0
PXFjb3cyLGlmPW5vbmUsaWQ9ZHJpdmUtdmlydGlvLWRpc2sxDQoJLWRldmljZSB2aXJ0aW8tYmxr
LXBjaSxzY3NpPW9mZixidXM9cGNpLjAsYWRkcj0weDksZHJpdmU9ZHJpdmUtdmlydGlvLWRpc2sx
LGlkPXZpcnRpby1kaXNrMSxib290aW5kZXg9MQ0KCS1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmls
ZSxpZD1tZW0xLHNoYXJlLG1lbS1wYXRoPS92aXJ0L252ZGltbTEsc2l6ZT0xNkcsYWxpZ249MTI4
TQ0KCS1kZXZpY2UgbnZkaW1tLG1lbWRldj1tZW0xLGlkPW52MSxsYWJlbC1zaXplPTJNLG5vZGU9
Mg0KCS1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxpZD1tZW0yLHNoYXJlLG1lbS1wYXRoPS92
aXJ0L252ZGltbTIsc2l6ZT0xNkcsYWxpZ249MTI4TQ0KCS1kZXZpY2UgbnZkaW1tLG1lbWRldj1t
ZW0yLGlkPW52MixsYWJlbC1zaXplPTJNLG5vZGU9Mw0KCS1zZXJpYWwgc3RkaW8NCgktZGlzcGxh
eSBub25lDQoNCkZvciB0aGUgY29tbWFuZCBsaXN0IC0gSSdtIHVzaW5nIFdJUCBwYXRjaGVzIHRv
IG5kY3RsL2RheGN0bCB0byBhZGQgdGhlDQpjb21tYW5kIEkgbWVudGlvbmVkIGVhcmxpZXIuIFVz
aW5nIHRoaXMgY29tbWFuZCwgSSBjYW4gcmVwcm9kdWNlIHRoZQ0KbG9ja2RlcCBpc3N1ZS4gSSB0
aG91Z2h0IEkgc2hvdWxkIGJlIGFibGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSBieQ0Kb25saW5p
bmcvb2ZmbGluaW5nIHRocm91Z2ggc3lzZnMgZGlyZWN0bHkgdG9vIC0gc29tZXRoaW5nIGxpa2U6
DQoNCiAgIG5vZGU9IiQoY2F0IC9zeXMvYnVzL2RheC9kZXZpY2VzL2RheDAuMC90YXJnZXRfbm9k
ZSkiDQogICBmb3IgbWVtIGluIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlIiRub2RlIi9t
ZW1vcnkqOyBkbw0KICAgICBlY2hvICJvZmZsaW5lIiA+ICRtZW0vc3RhdGUNCiAgIGRvbmUNCg0K
QnV0IHdpdGggdGhhdCBJIGNhbid0IHJlcHJvZHVjZSB0aGUgcHJvYmxlbS4NCg0KSSdsbCB0cnkg
dG8gZGlnIGEgYml0IGRlZXBlciBpbnRvIHdoYXQgbWlnaHQgYmUgaGFwcGVuaW5nLCB0aGUgZGF4
Y3RsDQptb2RpZmljYXRpb25zIHNpbXBseSBhbW91bnQgdG8gZG9pbmcgdGhlIHNhbWUgdGhpbmcg
YXMgYWJvdmUgaW4gQywgc28NCkknbSBub3QgaW1tZWRpYXRlbHkgc3VyZSB3aGF0IG1pZ2h0IGJl
IGhhcHBlbmluZy4NCg0KSWYgeW91J3JlIGludGVyZXN0ZWQsIEkgY2FuIHBvc3QgdGhlIG5kY3Rs
IHBhdGNoZXMgLSBtYXliZSBhcyBhbiBSRkMgLQ0KdG8gdGVzdCB3aXRoLg0KDQpUaGFua3MsDQot
VmlzaGFsDQoNCg0KDQo=

Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96779C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951802084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfDZAAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:00:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:18064 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfDZAAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:00:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 17:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; 
   d="scan'208";a="138898243"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga006.jf.intel.com with ESMTP; 25 Apr 2019 17:00:44 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 17:00:44 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.120]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 17:00:44 -0700
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     Sasha Levin <sashal@kernel.org>, Joseph Yasi <joe.yasi@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "e1000-devel@lists.sourceforge.net" 
        <e1000-devel@lists.sourceforge.net>
Subject: RE: [PATCH 1/2] Revert "e1000e: fix cyclic resets at link up with
 active tx"
Thread-Topic: [PATCH 1/2] Revert "e1000e: fix cyclic resets at link up with
 active tx"
Thread-Index: AQHU9PWDXnsTk6v0rkGLLfpWFtfVXKZNm+oQ
Date:   Fri, 26 Apr 2019 00:00:44 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9703A782@ORSMSX103.amr.corp.intel.com>
References: <155548879651.3454.13167784936351314661.stgit@buzz>
In-Reply-To: <155548879651.3454.13167784936351314661.stgit@buzz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzkwODk3MWQtMzMxNi00YmNjLTgxNmQtMDEzMWM3MjdlOWFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV1M1NGVUN1U5SXRvWkNaUnlBZVgycGU0Yys2TUI4WjBDQ2FGYTAzZUVranJpWTEwcEJoUmsyaEFSczJkdldkTCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBLb25zdGFudGluIEtobGVibmlrb3YgW21haWx0bzpraGxlYm5pa292QHlhbmRleC10
ZWFtLnJ1XQ0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE3LCAyMDE5IDE6MTMgQU0NCj4gVG86
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgS2lyc2hlciwgSmVmZnJleSBUIDxq
ZWZmcmV5LnQua2lyc2hlckBpbnRlbC5jb20+DQo+IENjOiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtl
cm5lbC5vcmc+OyBKb3NlcGggWWFzaSA8am9lLnlhc2lAZ21haWwuY29tPjsNCj4gQnJvd24sIEFh
cm9uIEYgPGFhcm9uLmYuYnJvd25AaW50ZWwuY29tPjsgQWxleGFuZGVyIER1eWNrDQo+IDxhbGV4
YW5kZXIuZHV5Y2tAZ21haWwuY29tPjsgZTEwMDAtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIFJldmVydCAiZTEwMDBlOiBmaXggY3ljbGljIHJlc2V0
cyBhdCBsaW5rIHVwIHdpdGggYWN0aXZlIHR4Ig0KPiANCj4gVGhpcyByZXZlcnRzIGNvbW1pdCAw
ZjllOTgwYmY1ZWUxYTk3ZTJlNDAxYzg0NmIyYWY5ODllYjIxYzYxLg0KPiANCj4gVGhhdCBjaGFu
Z2UgY2FzZWQgZmFsc2UtcG9zaXRpdmUgd2FybmluZyBhYm91dCBoYXJkd2FyZSBoYW5nOg0KPiAN
Cj4gZTEwMDBlOiBldGgwIE5JQyBMaW5rIGlzIFVwIDEwMDAgTWJwcyBGdWxsIER1cGxleCwgRmxv
dyBDb250cm9sOiBSeC9UeA0KPiBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogZXRoMDog
bGluayBiZWNvbWVzIHJlYWR5DQo+IGUxMDAwZSAwMDAwOjAwOjFmLjYgZXRoMDogRGV0ZWN0ZWQg
SGFyZHdhcmUgVW5pdCBIYW5nOg0KPiAgICBUREggICAgICAgICAgICAgICAgICA8MD4NCj4gICAg
VERUICAgICAgICAgICAgICAgICAgPDE+DQo+ICAgIG5leHRfdG9fdXNlICAgICAgICAgIDwxPg0K
PiAgICBuZXh0X3RvX2NsZWFuICAgICAgICA8MD4NCj4gYnVmZmVyX2luZm9bbmV4dF90b19jbGVh
bl06DQo+ICAgIHRpbWVfc3RhbXAgICAgICAgICAgIDxmZmZiYTdhNz4NCj4gICAgbmV4dF90b193
YXRjaCAgICAgICAgPDA+DQo+ICAgIGppZmZpZXMgICAgICAgICAgICAgIDxmZmZiYjE0MD4NCj4g
ICAgbmV4dF90b193YXRjaC5zdGF0dXMgPDA+DQo+IE1BQyBTdGF0dXMgICAgICAgICAgICAgPDQw
MDgwMDgwPg0KPiBQSFkgU3RhdHVzICAgICAgICAgICAgIDw3OTQ5Pg0KPiBQSFkgMTAwMEJBU0Ut
VCBTdGF0dXMgIDwwPg0KPiBQSFkgRXh0ZW5kZWQgU3RhdHVzICAgIDwzMDAwPg0KPiBQQ0kgU3Rh
dHVzICAgICAgICAgICAgIDwxMD4NCj4gZTEwMDBlOiBldGgwIE5JQyBMaW5rIGlzIFVwIDEwMDAg
TWJwcyBGdWxsIER1cGxleCwgRmxvdyBDb250cm9sOiBSeC9UeA0KPiANCj4gQmVzaWRlcyB3YXJu
aW5nIGV2ZXJ5dGhpbmcgd29ya3MgZmluZS4NCj4gT3JpZ2luYWwgaXNzdWUgd2lsbCBiZSBmaXhl
ZCBwcm9wZXJ0eSBpbiBmb2xsb3dpbmcgcGF0Y2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLb25z
dGFudGluIEtobGVibmlrb3YgPGtobGVibmlrb3ZAeWFuZGV4LXRlYW0ucnU+DQo+IFJlcG9ydGVk
LWJ5OiBKb3NlcGggWWFzaSA8am9lLnlhc2lAZ21haWwuY29tPg0KPiBMaW5rOiBodHRwczovL2J1
Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwMzE3NQ0KPiAtLS0NCj4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAwZS9uZXRkZXYuYyB8ICAgMTUgKysrKysrKysrLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0K
DQpUZXN0ZWQtYnk6IEFhcm9uIEJyb3duIDxhYXJvbi5mLmJyb3duQGludGVsLmNvbT4NClRoaXMg
d2FzIG1vcmUgb2YgYSByZWdyZXNzaW9uIGNoZWNrIGFzIEkgbmV2ZXIgZGlkIG1hbmFnZSB0byBy
ZXBsaWNhdGUgdGhlIHR4IGhhbmcsIGV2ZW4gd2l0aCBzZWVtaW5nbHkgdGhlIHNhbWUgaGFyZHdh
cmUuDQo=

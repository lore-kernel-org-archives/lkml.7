Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72F2C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A5F217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfICDQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 23:16:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45701 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfICDQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:16:53 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x833GneI013859, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x833GneI013859
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Sep 2019 11:16:49 +0800
Received: from RTITMBSVM03.realtek.com.tw ([fe80::e1fe:b2c1:57ec:f8e1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Tue, 3 Sep
 2019 11:16:48 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] r8152: modify rtl8152_set_speed function
Thread-Topic: [PATCH net-next] r8152: modify rtl8152_set_speed function
Thread-Index: AQHVYYTrRMaVJv63vEGfeZKbVbiDuqcYMZIAgAEQO0A=
Date:   Tue, 3 Sep 2019 03:16:48 +0000
Message-ID: <0835B3720019904CB8F7AA43166CEEB2F18DAB41@RTITMBSVM03.realtek.com.tw>
References: <1394712342-15778-326-Taiwan-albertk@realtek.com>
 <280e6a3d-c6c3-ef32-a65d-19566190a1d3@gmail.com>
In-Reply-To: <280e6a3d-c6c3-ef32-a65d-19566190a1d3@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.177.214]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVpbmVyIEthbGx3ZWl0IFttYWlsdG86aGthbGx3ZWl0MUBnbWFpbC5jb21dDQo+IFNlbnQ6IFR1
ZXNkYXksIFNlcHRlbWJlciAwMywgMjAxOSAyOjM3IEFNDQpbLi4uXQ0KPiBTZWVpbmcgYWxsIHRo
aXMgY29kZSBpdCBtaWdodCBiZSBhIGdvb2QgaWRlYSB0byBzd2l0Y2ggdGhpcyBkcml2ZXINCj4g
dG8gcGh5bGliLCBzaW1pbGFyIHRvIHdoYXQgSSBkaWQgd2l0aCByODE2OSBzb21lIHRpbWUgYWdv
Lg0KDQpJdCBpcyB0b28gY29tcGxleCB0byBiZSBjb21wbGV0ZWQgZm9yIG1lIGF0IHRoZSBtb21l
bnQuDQpJZiB0aGlzIHBhdGNoIGlzIHVuYWNjZXB0YWJsZSwgSSB3b3VsZCBzdWJtaXQgb3RoZXIN
CnBhdGNoZXMgZmlyc3QuIFRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzLA0KSGF5ZXMNCg0KDQo=

Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE3CC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E69520449
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbfHBH7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:59:48 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:56232 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfHBH7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:59:48 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 4D06467A8D8;
        Fri,  2 Aug 2019 09:59:45 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 2 Aug 2019
 09:59:44 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Fri, 2 Aug 2019 09:59:44 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] serial: sh-sci: Remove check for specific
 mctrl_gpio_init() return value
Thread-Topic: [PATCH v2 2/3] serial: sh-sci: Remove check for specific
 mctrl_gpio_init() return value
Thread-Index: AQHVSJlHEoc0h/HtdUeNtLGwgfHXXKbmn5QAgAC+MAA=
Date:   Fri, 2 Aug 2019 07:59:44 +0000
Message-ID: <75b5875d-fa88-3995-6776-ac9a67a3de3c@kontron.de>
References: <20190801184505.17239-1-frieder.schrempf@kontron.de>
 <20190801184505.17239-2-frieder.schrempf@kontron.de>
 <20190801203902.xie5dexnsoqxxlat@pengutronix.de>
In-Reply-To: <20190801203902.xie5dexnsoqxxlat@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DB2351A1567814DB91DE6E1D595A641@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 4D06467A8D8.AF499
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: festevam@gmail.com, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, jslaby@suse.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDguMTkgMjI6MzksIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBPbiBUaHUsIEF1
ZyAwMSwgMjAxOSBhdCAwNjo0NToyNFBNICswMDAwLCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0K
Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0K
Pj4NCj4+IE5vdyB0aGF0IHRoZSBtY3RybF9ncGlvIGNvZGUgcmV0dXJucyBOVUxMIGluc3RlYWQg
b2YgRVJSX1BUUigtRU5PU1lTKQ0KPj4gaW4gY2FzZXMgd2hlbiBDT05GSUdfR1BJT0xJQiBpcyBk
aXNhYmxlZCwgd2UgY2FuIHNhZmVseSByZW1vdmUgdGhpcw0KPj4gY2hlY2suDQo+IA0KPiBJIHdv
dWxkIG1lbnRpb24gLUVOT1NZUyBpbiB0aGUgU3ViamVjdCBsaW5lLiBTb21ldGhpbmcgbGlrZToN
Cj4gDQo+IAlzZXJpYWw6IHNoLXNjaTogZG9uJ3QgY2hlY2sgZm9yIG1jdHJsX2dwaW9faW5pdCBy
ZXR1cm5pbmcgLUVOT1NZUw0KPiANCj4gCU5vdyB0aGF0IHRoZSBtY3RybF9ncGlvIGNvZGUgcmV0
dXJucyBOVUxMIGluc3RlYWQgb2YNCj4gCUVSUl9QVFIoLUVOT1NZUykgaWYgQ09ORklHX0dQSU9M
SUIgaXMgZGlzYWJsZWQsIHdlIGNhbiBzYWZlbHkNCj4gCXJlbW92ZSB0aGlzIGNoZWNrLg0KDQpJ
bmRlZWQsIEkgZmFpbGVkIHRvIGNvbWUgdXAgd2l0aCBhIGJldHRlciBzdWJqZWN0IGxpbmUuIEkg
d2lsbCBhZG9wdCANCnlvdXIgcHJvcG9zYWwuDQoNCj4gVGhhbmtzDQo+IFV3ZQ0KPiA=

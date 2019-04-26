Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD370C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D468208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfDZP3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:29:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37646 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfDZP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:29:41 -0400
Received: from localhost (unknown [12.154.31.190])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 28E6B145E49BF;
        Fri, 26 Apr 2019 08:29:41 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:29:39 -0400 (EDT)
Message-Id: <20190426.112939.1227994731110797983.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     leedom@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH net-next] cxgb4/cxgb4vf_main: Mark expected switch
 fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190424162742.GA10085@embeddedor>
References: <20190424162742.GA10085@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Apr 2019 08:29:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogV2VkLCAyNCBBcHIgMjAxOSAxMToyNzo0MiAtMDUwMA0KDQo+IEluIHByZXBhcmF0aW9uIHRv
IGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoDQo+IGNhc2VzIHdo
ZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4gVGhpcyBwYXRjaCBm
aXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9j
aGVsc2lvL2N4Z2I0dmYvY3hnYjR2Zl9tYWluLmM6IEluIGZ1bmN0aW9uIKFmd2V2dHFfaGFuZGxl
cqI6DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2NoZWxzaW8vY3hnYjR2Zi9jeGdiNHZmX21haW4u
Yzo1MjA6Nzogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBs
aWNpdC1mYWxsdGhyb3VnaD1dDQo+ICAgIGNwbCA9ICh2b2lkICopcDsNCj4gICAgfn5+fl5+fn5+
fn5+fn5+DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2NoZWxzaW8vY3hnYjR2Zi9jeGdiNHZmX21h
aW4uYzo1MjQ6Mjogbm90ZTogaGVyZQ0KPiAgIGNhc2UgQ1BMX1NHRV9FR1JfVVBEQVRFOiB7DQo+
ICAgXn5+fg0KPiANCj4gV2FybmluZyBsZXZlbCAzIHdhcyB1c2VkOiAtV2ltcGxpY2l0LWZhbGx0
aHJvdWdoPTMNCj4gDQo+IE5vdGljZSB0aGF0LCBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSwgdGhl
IGNvZGUgY29tbWVudCBpcyBtb2RpZmllZA0KPiBpbiBhY2NvcmRhbmNlIHdpdGggd2hhdCBHQ0Mg
aXMgZXhwZWN0aW5nIHRvIGZpbmQuDQo+IA0KPiBUaGlzIHBhdGNoIGlzIHBhcnQgb2YgdGhlIG9u
Z29pbmcgZWZmb3J0cyB0byBlbmFibGUNCj4gLVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5j
b20+DQoNCkFwcGxpZWQuDQo=

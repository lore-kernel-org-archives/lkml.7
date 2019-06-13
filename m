Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBF7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6D921473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfFMVNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:13:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60416 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbfFMVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:13:06 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 21882149CFFF7;
        Thu, 13 Jun 2019 14:13:06 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:13:05 -0700 (PDT)
Message-Id: <20190613.141305.616954421778433913.davem@davemloft.net>
To:     yamada.masahiro@socionext.com
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: fix unknown type name u_int in uapi header
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190604082314.25939-1-yamada.masahiro@socionext.com>
References: <20190604082314.25939-1-yamada.masahiro@socionext.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Jun 2019 14:13:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4NCkRh
dGU6IFR1ZSwgIDQgSnVuIDIwMTkgMTc6MjM6MTQgKzA5MDANCg0KPiAndV9pbnQnIGlzIGEgc2hv
cnRoYW5kIHRoYXQgaXMgb25seSBhdmFpbGFibGUgaW4gdGhlIGtlcm5lbCBzcGFjZQ0KPiBiZWNh
dXNlIGl0IGlzIGRlZmluZWQgaW4gaW5jbHVkZS9saW51eC90eXBlcy5oLCB3aGljaCBpcyBub3Qg
ZXhwb3J0ZWQNCj4gdG8gdGhlIHVzZXIgc3BhY2UuDQo+IA0KPiBZb3UgY2Fubm90IHVzZSBpdCBp
biB1YXBpIGhlYWRlcnMgZXZlbiBpZiB5b3UgaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gDQo+
IERldGVjdGVkIGJ5IGNvbXBpbGUtdGVzdGluZyBleHBvcnRlZCBoZWFkZXJzLg0KPiANCj4gLi91
c3IvaW5jbHVkZS9hc20vb3BlbnByb21pby5oOjE2OjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFt
ZSChdV9pbnSiDQo+ICAgdV9pbnQgb3Byb21fc2l6ZTsgIC8qIEFjdHVhbCBzaXplIG9mIHRoZSBv
cHJvbV9hcnJheS4gKi8NCj4gICBefn5+fg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8g
WWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4NCg0KQXBwbGllZC4NCg==

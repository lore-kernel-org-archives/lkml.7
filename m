Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E114C31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBFE20657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfFSCd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:33:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56756 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSCd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:33:58 -0400
Received: from localhost (unknown [8.46.76.24])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6AE5214DB3D3F;
        Tue, 18 Jun 2019 19:33:49 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:33:43 -0400 (EDT)
Message-Id: <20190618.223343.1129504320231308025.davem@davemloft.net>
To:     nhuck@google.com
Cc:     maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] net: mvpp2: cls: Add pmap to fs dump
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190618160910.62922-1-nhuck@google.com>
References: <20190618083900.78eb88bd@bootlin.com>
        <20190618160910.62922-1-nhuck@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Jun 2019 19:33:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmF0aGFuIEh1Y2tsZWJlcnJ5IDxuaHVja0Bnb29nbGUuY29tPg0KRGF0ZTogVHVlLCAx
OCBKdW4gMjAxOSAwOTowOToxMCAtMDcwMA0KDQo+ICsJZGRlYnVnZnNfY3JlYXRlX2ZpbGUoInBt
YXAiLCAwNDQ0LCBwcnNfZW50cnlfZGlyLCBlbnRyeSwNCg0KZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWFydmVsbC9tdnBwMi9tdnBwMl9kZWJ1Z2ZzLmM6IEluIGZ1bmN0aW9uIKFtdnBwMl9kYmdmc19w
cnNfZW50cnlfaW5pdKI6DQpkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL212cHAyL212cHAy
X2RlYnVnZnMuYzo1Njk6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9u
IKFkZGVidWdmc19jcmVhdGVfZmlsZaI7IGRpZCB5b3UgbWVhbiChZGVidWdmc19jcmVhdGVfZmls
ZaI/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KDQpUaGlzIGRvZXNu
J3QgY29tcGlsZSwgZGlkIHlvdSBidWlsZCB0ZXN0IHRoaXM/DQo=

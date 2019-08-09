Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C33C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FC52171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405493AbfHIFcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 01:32:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56178 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfHIFcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 01:32:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AF1831433DB45;
        Thu,  8 Aug 2019 22:32:47 -0700 (PDT)
Date:   Thu, 08 Aug 2019 22:32:47 -0700 (PDT)
Message-Id: <20190808.223247.493228946898420743.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        dave.taht@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] fq_codel: remove set but not used variables
 'prev_ecn_mark' and 'prev_drop_count'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190808.223136.1507513183278607177.davem@davemloft.net>
References: <20190807131055.66668-1-yuehaibing@huawei.com>
        <20190808.223136.1507513183278607177.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Aug 2019 22:32:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KRGF0ZTogVGh1LCAwOCBB
dWcgMjAxOSAyMjozMTozNiAtMDcwMCAoUERUKQ0KDQo+IEZyb206IFl1ZUhhaWJpbmcgPHl1ZWhh
aWJpbmdAaHVhd2VpLmNvbT4NCj4gRGF0ZTogV2VkLCA3IEF1ZyAyMDE5IDIxOjEwOjU1ICswODAw
DQo+IA0KPj4gRml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOg0K
Pj4gDQo+PiBuZXQvc2NoZWQvc2NoX2ZxX2NvZGVsLmM6IEluIGZ1bmN0aW9uIGZxX2NvZGVsX2Rl
cXVldWU6DQo+PiBuZXQvc2NoZWQvc2NoX2ZxX2NvZGVsLmM6Mjg4OjIzOiB3YXJuaW5nOiB2YXJp
YWJsZSBwcmV2X2Vjbl9tYXJrIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFy
aWFibGVdDQo+PiBuZXQvc2NoZWQvc2NoX2ZxX2NvZGVsLmM6Mjg4OjY6IHdhcm5pbmc6IHZhcmlh
YmxlIHByZXZfZHJvcF9jb3VudCBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZh
cmlhYmxlXQ0KPj4gDQo+PiBUaGV5IGFyZSBub3QgdXNlZCBzaW5jZSBjb21taXQgNzdkZGFmZjIx
OGZjICgiZnFfY29kZWw6IEtpbGwNCj4+IHVzZWxlc3MgcGVyLWZsb3cgZHJvcHBlZCBzdGF0aXN0
aWMiKQ0KPj4gDQo+PiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+DQo+
IA0KPiBEbyB5b3UgZXZlbiBjb21waWxlIHRlc3QgdGhpcyBzdHVmZj8NCj4gDQo+ICAgQ0MgW01d
ICBuZXQvc2NoZWQvc2NoX2ZxX2NvZGVsLm8NCj4gbmV0L3NjaGVkL3NjaF9mcV9jb2RlbC5jOiBJ
biBmdW5jdGlvbiChZnFfY29kZWxfZGVxdWV1ZaI6DQo+IG5ldC9zY2hlZC9zY2hfZnFfY29kZWwu
YzozMDk6NDI6IGVycm9yOiChcHJldl9kcm9wX2NvdW50oiB1bmRlY2xhcmVkIChmaXJzdCB1c2Ug
aW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiChcGFnZV9yZWZfY291bnSiPw0KDQpOZXZl
ciBtaW5kLCB0aGlzIGlzIG15IGZhdWx0Lg0KDQpJIHdhcyBidWlsZCB0ZXN0aW5nIHRoZSBwYXRj
aCBvbiB0aGUgd3JvbmcgdHJlZSwgSSdtIHZlcnkgc29ycnkuDQo=

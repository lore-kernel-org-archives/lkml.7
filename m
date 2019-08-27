Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0553CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D235720656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfH0Ut0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:49:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50602 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfH0UtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:49:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0AA3E152804BA;
        Tue, 27 Aug 2019 13:49:25 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:49:22 -0700 (PDT)
Message-Id: <20190827.134922.1122516005541933425.davem@davemloft.net>
To:     wang.yi59@zte.com.cn
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        cheng.lin130@zte.com.cn
Subject: Re: [PATCH] ipv6: Not to probe neighbourless routes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1566896907-5121-1-git-send-email-wang.yi59@zte.com.cn>
References: <1566896907-5121-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 27 Aug 2019 13:49:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpOb3RoaW5nIHNheXMgImxvdyBxdWFsaXR5IHBhdGNoIHN1Ym1pc3Npb24iIGxpa2U6DQoNCm5l
dC9pcHY2L3JvdXRlLmM6IEluIGZ1bmN0aW9uIKFydDZfcHJvYmWiOg0KbmV0L2lwdjYvcm91dGUu
Yzo2NjA6MTA6IGVycm9yOiChc3RydWN0IGZpYjZfbmiiIGhhcyBubyBtZW1iZXIgbmFtZWQgoWxh
c3RfcHJvYmWiDQogICBmaWI2X25oLT5sYXN0X3Byb2JlID0gamlmZmllczsNCg0KIkkgZGlkIG5v
dCBldmVuIHRyeSB0byBjb21waWxlIHRoaXMiDQo=

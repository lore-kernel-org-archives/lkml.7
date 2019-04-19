Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30F1C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A449217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="jlCbgQtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfDSCBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:01:33 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:57295 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfDSCBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 22:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1555639287;
        bh=MepexU0iTscd2IW5I8kn0yY9P9NlfHnmIZmXJO0VyLo=;
        h=From:To:Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:Message-ID;
        b=jlCbgQtCwDlBDAVLv31ySHCiyjlchnZ1a1MPBdaad/XU6LOjjWoVgyWK0Dlw2sug8
         Etg4P4hLgbp4p46MKvuHYabO3N6SF/WUcOml5jApGiqOdkOvn0u4+NlklYxZ2L94WL
         MhF18gE+UH5scZS59Ee31WMYirt7yrOddJ3vwiFc=
X-QQ-FEAT: jfJxHuYZxOBPSDhREzDobKD9vlA6L+SfAUnSublIxtfQbkfbUFIfYWeBHJO29
        aNRUMlqeZyqrV3L4sCJ9LUr4sM4JAZfEjoZ9mn8g8hMrDnb7LXb3iYJhKQpNwPTnTBhih8n
        WsJ9dXj4okFPRi+KXJk3AkLTlHWMvWaFawW/pl949QVg0qm5D8hOgvYZpvlnHjwHCQCNcUX
        9iCOPSz3mryG3HzuvLyEEgHdkRT/BxaMgnC3gSJAACnaubXYqp5/s4Au5KcQBmeZf+YSzXA
        GX3yZuXGXXTWrN7IhSu7b0JoE=
X-QQ-SSF: 000000000000002000000000000000V
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 202.120.10.167
X-QQ-STYLE: 
X-QQ-mid: webmail166t1555639286t6758160
From:   "=?ISO-8859-1?B?UGx1c09uZVNlY29uZA==?=" <plusonesecond@foxmail.com>
To:     "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: net: ax25: %x specifier misuse in kernel?
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Fri, 19 Apr 2019 10:01:25 +0800
X-Priority: 3
Message-ID: <tencent_3A04033395F30A3361F8A78F814E1FF92B07@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Fri, 19 Apr 2019 10:01:27 +0800 (CST)
Feedback-ID: webmail:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gYXgyNV9pbmZvX3Nob3cgb2YgYWZfYXgyNS5jOjE4OTEsIGxpbnV4LTUuMS4KVGhlIHBv
aW50ZXIgYXgyNSBpcyBjYXN0IHRvIGxvbmcgdHlwZSB0byBwcmludCBvdXQuCgpXaHkgaXQg
cHJpbnRzIHRoZSBhIHBvaW50ZXIgJ2F4MjUnIHVzZSAlOC44bHggcmF0aGVyIHRoYW4gJXA/
CklmIGl0IHJlYWxseSB3YW50IHRvIHByaW50IHRoZSB2YWx1ZSBvZiBheDI1LCBpdCBzaG91
bGQgdXNlICVweC4KCkFsc28sIEkgIHNjYW4gdGhlIGtlcm5lbCBjb2RlIGFuZCBub3RpY2Ug
dGhhdCBtb3N0IG9mIHRoZSBwb2ludGVycyBjYXN0IHRvIGxvbmcgb3IgdW5zaWduZWQgbG9u
ZyB0eXBlIHRvIHByaW50IG91dCBhcmUgbWFya2VkIHdpdGggX19pb21lbS4KSXMgaXQgYSBt
aXN1c2Ugb2YgJXg/CgoKVGhhbmtzLg==




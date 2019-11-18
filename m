Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC08C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43F820692
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfKRJUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:20:55 -0500
Received: from smtpbgeu1.qq.com ([52.59.177.22]:38617 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfKRJUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:20:55 -0500
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: ueeW6WFna0ImniAvIyR16PDRsSY7tegEXsv5sbzBpVJFW82hV8ZQwgYv00ylY
        Nyo6+/jx8YTs1E4C1qlmKZgnZVPid7nIdTMOp6nrK4v0F9ojCdBKudYSKegVbvfXjj8BsuB
        dAQms5WBAiJHnksWYvaIBjDfoYDXE2qIZhOA03uHsd4vJ4f4sEQkGXR9JOMjYblQ2p1YpBj
        4rcwgTzciigpHyVCJFhVYZnHRBUPMw/sRSgGPybzL06/vwdmWKXuNWRalfx38R6j/bG/g+1
        4VQfa/OeodSdE4dnR3Wm0XwXCznRP4U6GFejVI483Ho/kK1c5q2e+aptw=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 218.76.220.175
X-QQ-STYLE: 
X-QQ-mid: bizmaillogic610t1574068847t56
From:   "=?utf-8?B?Wmhlbmd5dWFuIExpdQ==?=" <liuzhengyuan@kylinos.cn>
To:     "=?utf-8?B?YnZhbmFzc2NoZQ==?=" <bvanassche@acm.org>,
        "=?utf-8?B?bWluZ28=?=" <mingo@kernel.org>,
        "=?utf-8?B?YWxleGFuZGVyLmxldmlu?=" <alexander.levin@microsoft.com>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Compilation error for target liblockdep
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon, 18 Nov 2019 17:20:47 +0800
X-Priority: 3
Message-ID: <tencent_221B7250536E082573770ABA@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Mon, 18 Nov 2019 17:20:49 +0800 (CST)
Feedback-ID: bizmaillogic:kylinos.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIGd1eXMsDQoNCkkgZ290IGEgY29tcGlsYXRpb24gZXJyb3Igd2hpbGUgYnVpbGRpbmcg
dGFyZ2V0IGxpYmxvY2tkZXAgYW5kIEkgdGhpbmsgSSdkDQpiZXR0ZXIgcmVwb3J0IGl0IHRv
IHlvdS4gVGhlIGVycm9yIGluZm8gc2hvd2VkIGFzIGJlbGxvdzoNCg0KICAgICAgICAjIGNk
IFNSQy90b29scw0KICAgICAgICAjIG1ha2UgbGlibG9ja2RlcA0KICAgICAgICAgIERFU0NF
TkQgIGxpYi9sb2NrZGVwDQogICAgICAgICAgQ0MgICAgICAgbG9ja2RlcC5vDQogICAgICAg
IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBsb2NrZGVwLmM6MzM6MDoNCiAgICAgICAgLi4vLi4v
Li4va2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjUzOjI4OiBmYXRhbCBlcnJvcjogbGludXgv
cmN1cGRhdGUuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KICAgICAgICBjb21waWxh
dGlvbiB0ZXJtaW5hdGVkLg0KICAgICAgICBtdjogY2Fubm90IHN0YXQgJy4vLmxvY2tkZXAu
by50bXAnOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQogICAgICAgIC9ob21lL2x6eS9r
ZXJuZWwtdXBzdHJlYW0vbGludXgtbGludXMtdWJ1bnR1L3Rvb2xzL2J1aWxkL01ha2VmaWxl
LmJ1aWxkOjk2OiByZWNpcGUgZm9yIHRhcmdldCAnbG9ja2RlcC5vJyBmYWlsZWQNCiAgICAg
ICAgbWFrZVsyXTogKioqIFtsb2NrZGVwLm9dIEVycm9yIDENCiAgICAgICAgTWFrZWZpbGU6
MTIxOiByZWNpcGUgZm9yIHRhcmdldCAnbGlibG9ja2RlcC1pbi5vJyBmYWlsZWQNCiAgICAg
ICAgbWFrZVsxXTogKioqIFtsaWJsb2NrZGVwLWluLm9dIEVycm9yIDINCiAgICAgICAgTWFr
ZWZpbGU6Njg6IHJlY2lwZSBmb3IgdGFyZ2V0ICdsaWJsb2NrZGVwJyBmYWlsZWQNCiAgICAg
ICAgbWFrZTogKioqIFtsaWJsb2NrZGVwXSBFcnJvciAyDQoNCkJUVywgSXQgd2FzIGludHJv
ZHVjZWQgYnkgY29tbWl0IGEwYjBmZDUzZTFlICgibG9ja2luZy9sb2NrZGVwOiBGcmVlIGxv
Y2sgY2xhc3NlcyB0aGF0IGFyZSBubyBsb25nZXIgaW4gdXNlIikuDQoNClRoYW5rcy4=




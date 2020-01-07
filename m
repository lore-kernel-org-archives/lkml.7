Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247C0C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0547021744
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgAGOXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:23:22 -0500
Received: from out28-196.mail.aliyun.com ([115.124.28.196]:42637 "EHLO
        out28-196.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgAGOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:23:21 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.10155|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.143375-0.00537265-0.851253;DS=CONTINUE|ham_social|0.0139022-0.000757724-0.98534;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.GXyhNcU_1578406987;
Received: from 192.168.1.7(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.GXyhNcU_1578406987)
          by smtp.aliyun-inc.com(10.147.41.199);
          Tue, 07 Jan 2020 22:23:08 +0800
Subject: Re: [PATCH 0/5] pinctrl: ingenic: cleanups
To:     Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
References: <20200106232711.559727-1-paul@crapouillou.net>
 <CACRpkdYo0dniDAq12WG=KWmJPjnuYEtDn=pvHRoRGRhzQUX58w@mail.gmail.com>
Cc:     od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <5E14944B.4060405@wanyeetech.com>
Date:   Tue, 7 Jan 2020 22:23:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYo0dniDAq12WG=KWmJPjnuYEtDn=pvHRoRGRhzQUX58w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2020年01月07日 20:35, Linus Walleij wrote:
> On Tue, Jan 7, 2020 at 12:27 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
>> I saw you merged Zhou's patchset, here are some cleanup patches for
>> pinctrl-ingenic that should be applied on top of his commits.
> All five patches applied!
>
> Zhou can you test the result? I am pushing the devel branch
> out and as soon as it builds cleanly I will push it for-next.

I tested it on JZ4760 and JZ4780. The hardware of X1000 and X1830 is not 
in my hand right now, I can test them tomorrow, but from the view of the 
code, it should work fine. You can add:
Tested-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>

Thanks and best regards!

>
> Yours,
> Linus Walleij


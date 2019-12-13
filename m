Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 02:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70422173E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 02:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfLMCuj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 21:50:39 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:50468 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726897AbfLMCuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 21:50:39 -0500
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id xBD2nRML016388
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 13 Dec 2019 10:49:27 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from lenovo (10.0.74.130) by BJMBX02.spreadtrum.com (10.0.64.8) with
 Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 13 Dec 2019 10:49:50 +0800
Date:   Fri, 13 Dec 2019 10:49:35 +0800
From:   Orson Zhai <orson.zhai@spreadtrum.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>
CC:     Orson Zhai <orson.zhai@unisoc.com>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <baolin.wang@unisoc.com>, <kevin.tang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        <liangcai.fan@unisoc.com>, <orsonzhai@gmail.com>
Subject: Re: [PATCH v3] mfd: syscon: Add arguments support for syscon
 reference
Message-ID: <20191213024935.GD9271@lenovo>
References: <1576037311-6052-1-git-send-email-orson.zhai@unisoc.com>
 <CAK8P3a0244jKrEop2rHVyJZ57h4A9+mqb-5g-wLUSfR2G1svwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0244jKrEop2rHVyJZ57h4A9+mqb-5g-wLUSfR2G1svwg@mail.gmail.com>
X-Originating-IP: [10.0.74.130]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX02.spreadtrum.com (10.0.64.8)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com xBD2nRML016388
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee and Rob,

On Wed, Dec 11, 2019 at 02:55:39PM +0100, Arnd Bergmann wrote:
> On Wed, Dec 11, 2019 at 5:09 AM Orson Zhai <orson.zhai@unisoc.com> wrote:
> >
> > There are a lot of similar global registers being used across multiple SoCs
> > from Unisoc. But most of these registers are assigned with different offset
> > for different SoCs. It is hard to handle all of them in an all-in-one
> > kernel image.
> >
> > Add a helper function to get regmap with arguments where we could put some
> > extra information such as the offset value.
> >
> > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > Tested-by: Baolin Wang <baolin.wang@unisoc.com>
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Does this patch look good to be applied?

Or if any comments please feel free to send to me.

Thank you!

Best Regards,
Orson
________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。

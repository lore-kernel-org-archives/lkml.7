Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E28C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41082081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCHJ2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:28:03 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfCHJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:28:03 -0500
Received: from [192.168.1.110] ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjjSt-1gdpPR3qvb-00lBm0; Fri, 08 Mar 2019 10:27:50 +0100
Subject: Re: [PATCH] fs: 9p: Kconfig: pedantic cleanups
To:     Dominique Martinet <asmadeus@codewreck.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net
References: <1551894972-5807-1-git-send-email-info@metux.net>
 <20190306232744.GA1286@nautica>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <116c5c69-b071-ad84-ce3b-1733e669b308@metux.net>
Date:   Fri, 8 Mar 2019 10:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190306232744.GA1286@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:poUFoj5GLPm2Dv9Fo4l0W1lzK0Jvtw+dg4/HM+xPl9v/ZtMsx/k
 cVlQgS7hJFs8pUxiA6QMPc2Dg7Yjoc8oYHFsjAUNmhYqe34tyjOqDpbVLnrjLdxFqpfae6T
 /a25YrX+ydGyGbm4B6UxQEi+cwBU2dFk4flmW8mVWUDSfmr7h78oaV4cSFRd+4z88six1ck
 eXlcRto5tBi/Zj8xw9HIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lrHLaOqIuLU=:QEys1dj0dE/nMVNPKed1nT
 hgF+a5uNSMkZXDiZ+YtNpMU+QbbHEa5D15Y+IjqWCrenq6ish7gBs+r9uG9s5fw6AyWlvO9eN
 6rOckaSSBHHQdp0tMEqEaiB7V8U24dJYJAnA2KGMnlBroTB5YAFXVs6cBsocgJz7gRkiSOQHN
 6cwOJs/3Hp0M1qHdmwtltmNoIkY0DrO07emgsMlSmJwh4wtDcRiGBZ2cUs3LI9KwWJp7+UsYW
 HakJ7izyQBa7gtFQMJ4i2faBzD6ps4m0NUnmy4ulIEC7d2RBD+UXTgJtk1seXcf7OjRGm53l8
 PZgoWyuJXR1jFpB8eZwIXkuG4Lp7i0Ps974yIoBlnhYKjDWDuS/J9qrNhKT1bEZGd0C/nZdDG
 dqa8UGIAf/V0WGSC/Oj7IMefL1bCArNY1OML0Xz09a+rVvpAYOm5vrLEVZn+cqn/ARxn5uAZH
 AU1sjxtyLLH3R+5+5/1I2Q9k+rR/J+D7fL6NhZZMHXnDEfpM1shn5cuVbLRlic1OaJhEK+L6P
 ALgJ96M2Ed3pljGYV272l135Qp5qA6RB+ifZUkMhzNpF9vbOn0UbKc0ffHVNJLBhi4D9ipuaV
 xeCOcbtNjxsP/OjkvQXm9oQgEtiVZWLNZ+FTl9ag6cEV+bPqQO8PfVuTLARRUd5zw/gvnVl7u
 f91kWw+kyp5HceKR6rk6TB8BcN0edafxCSlbmrMrIBXED/5pzAGGoRoY1xPo0P4oPxGWi5a9f
 SOWa/VsEzlpBN6yEg6eBp6WsylxtWL+NSwzUBmD4NmI0w8w4AU2BV+qsnqw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.19 00:27, Dominique Martinet wrote:
> Enrico Weigelt, metux IT consult wrote on Wed, Mar 06, 2019:
>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> I don't mind trivial patches but please resend with a description of
> what is done (change spaces to tabs) in the commit message.

Sorry, forgot that. I've made over 100 of those patches for the various
areas (most of them not even sent out yet), so a lot of copy+paste of
commit messages :o

I'll resend a fixed patch.


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A91CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B400920874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390451AbfJ2Qee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:34:34 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36354 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390192AbfJ2Qee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:34:34 -0400
X-Greylist: delayed 613 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Oct 2019 12:34:33 EDT
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 152FD1C01DC; Tue, 29 Oct 2019 17:24:19 +0100 (CET)
Date:   Tue, 29 Oct 2019 17:24:19 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/93] 4.19.81-stable review
Message-ID: <20191029162419.cumhku6smn2x2bq4@ucw.cz>
References: <20191027203251.029297948@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 4.19.81 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue 29 Oct 2019 08:27:02 PM UTC.
> Anything received after that time might be too late.

> Date: Tue, 29 Oct 2019 10:19:29 +0100
> From: Greg KH <gregkh@linuxfoundation.org>
> To: linux-kernel@vger.kernel.org, Andrew Morton
> Subject: Linux 4.19.81

> [-- The following data is signed --]

>  I'm announcing the release of the 4.19.81 kernel.

> All users of the 4.19 kernel series must upgrade.

Am I confused or was the 4.19.81 released a bit early?

Best regards,
										Pavel

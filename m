Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65564C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BD820851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbfCAOGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:06:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38724 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbfCAOGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:06:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id s1so27823171qte.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1b7y7waQ8hhL6ut9xp+6v52NZZ0Vu2oWVZyysdb2PZ4=;
        b=k4A9kFMAB29kxwbg2v+I1U/ZN9SGhL3L2ugOwsxKTYjPvIR0hKetxr9/YNXqdU7K0m
         owRcb9Z08l/ifKMFX7X29qexCIiV8gYMe3ckQqzLV4mBwtl9p3NQ3ZMEA+YAC12+Mazg
         8bv1nLvhum7F89A94qwi+NeIaIkxPGWJjFur4/q6HyoQiwVFzVGITfaW4RqjE36Np7Ff
         OSck3sWJE2cj7OQ1dZTbSQlDK1SFS5gDOak471BTb/p+7mYoi9l14CqACxE3SsqGkEiy
         lNHhHHA7HCM/o1A88TTd/9ruoOE97804Yk4LX11IghptJlE7KBrHfRlxUuiuEHdGBaiz
         JIeA==
X-Gm-Message-State: APjAAAXFlMS0RvmlFTG1Xe7huEa0dyE9JpmdfM3nJXx8P4XcPEmd5kyr
        aiTfyS1CQRcNhL0RzgQSzR44P06YQun4JZVPlPA=
X-Google-Smtp-Source: APXvYqwW5Pv1xNve6qkC70Yc74LVdB2FRNlYpAsjfnBu6MkbNmvyg6M8d9VF4KTv8pdymKtArC7wcey8pmboywkSCBA=
X-Received: by 2002:a0c:b501:: with SMTP id d1mr2059328qve.115.1551449194768;
 Fri, 01 Mar 2019 06:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20190227205211.32425-1-leoyang.li@nxp.com>
In-Reply-To: <20190227205211.32425-1-leoyang.li@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 Mar 2019 15:06:18 +0100
Message-ID: <CAK8P3a3+TBkkVCwSfGVMoVLckzsUPhtzMFap1pNAif9gVmvxxw@mail.gmail.com>
Subject: Re: [GIT PULL] updates to soc/fsl drivers for v5.1 take4
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 9:52 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> Hi arm-soc maintainers,
>
> Since we are having a -rc8 for v5.0, please help to merge a few additional
> patches for the upcoming merge window.  Thanks

Pulled into arm/drivers, thanks!

     Arnd

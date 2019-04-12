Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C93DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84EA2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gHSpe3J5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfDLIbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:31:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41594 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfDLIbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:31:52 -0400
Received: from zn.tnic (p200300EC2F0884007C96562F0B339423.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8400:7c96:562f:b33:9423])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D35C1EC0429;
        Fri, 12 Apr 2019 10:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555057911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TCN170+E5a0K5AvAV4xKi9fyH/NfQmKuYSXlGug6uWM=;
        b=gHSpe3J5a+HzlVQ/cpF45vG014cY36f5o1QhaW3qLYD7SRs34HYh85iMWF9ZFnsMrznV1X
        Pv9QQyl2NW6JUQd1ZJcktFPW7Lh6D58RRizYAcg5fv/R72z6+JtgOex0zUHsFHd4zq9Qjk
        OTbYVWMpffy/o5ggZgJKzDoXU+/qQ7E=
Date:   Fri, 12 Apr 2019 10:31:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v3 3/4] x86: Use HYPERVISOR_CALLBACK_VECTOR for
 acrn_guest upcall vector
Message-ID: <20190412083147.GB19808@zn.tnic>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-4-git-send-email-yakui.zhao@intel.com>
 <20190408150011.GH15689@zn.tnic>
 <36ff9827-da90-0736-f0a4-2f38b9c8bf3b@intel.com>
 <20190411135547.GH30080@zn.tnic>
 <1aaea739-ded7-13da-c2d0-54423de0eab0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1aaea739-ded7-13da-c2d0-54423de0eab0@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 09:00:10AM +0800, Zhao, Yakui wrote:
> This is not a problem.
> I take a look at the header file of mshyperv.h and xen/events.h.
> It seems that they have no such extra conditional definition.
> To follow the same style, I will remove it.

Yes, the less ifdeffery the better. If it is not really needed.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

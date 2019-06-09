Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B5C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 18:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27139206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 18:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfFISkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 14:40:22 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:58388 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbfFISkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 14:40:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 0BA6413D02E3;
        Sun,  9 Jun 2019 20:40:20 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PVHEsyn7Y6u4; Sun,  9 Jun 2019 20:40:18 +0200 (CEST)
Received: from probook (x4db417da.dyn.telefonica.de [77.180.23.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Sun,  9 Jun 2019 20:40:18 +0200 (CEST)
Date:   Sun, 9 Jun 2019 20:40:13 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Klaus Kusche <klaus.kusche@computerix.info>
Cc:     keescook@chromium.org, bp@suse.de, samitolvanen@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <20190609184013.GA11237@probook>
References: <502d5b36-e0d0-ffcc-5dd4-35db9d033561@computerix.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <502d5b36-e0d0-ffcc-5dd4-35db9d033561@computerix.info>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019 Jun 09, Klaus Kusche wrote:
> 
> Hello,
> 
> Same problem for linux 5.1.7: 
> Kernel building fails with the same relocation error.
> 
> 5.1.5 does not have the problem, builds fine for me.
> 
> Is there anything I can do to investigate the problem?
> 

Please try linux 5.1.8. The problematic patch was reverted there.

-- 
Regards,
  Johannes


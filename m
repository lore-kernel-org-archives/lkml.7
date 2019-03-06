Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FCFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE71206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCFX2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:28:01 -0500
Received: from nautica.notk.org ([91.121.71.147]:49897 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFX2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:28:00 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id AF121C009; Thu,  7 Mar 2019 00:27:59 +0100 (CET)
Date:   Thu, 7 Mar 2019 00:27:44 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] fs: 9p: Kconfig: pedantic cleanups
Message-ID: <20190306232744.GA1286@nautica>
References: <1551894972-5807-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551894972-5807-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enrico Weigelt, metux IT consult wrote on Wed, Mar 06, 2019:
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

I don't mind trivial patches but please resend with a description of
what is done (change spaces to tabs) in the commit message.

That aside I gues there's no harm in it, thanks for the boring work.

-- 
Dominique

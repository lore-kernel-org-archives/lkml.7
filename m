Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F260C20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfDAUQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:16:10 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:56684 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbfDAUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:16:10 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hB3Lj-0006GB-78; Mon, 01 Apr 2019 22:16:07 +0200
Date:   Mon, 1 Apr 2019 22:16:07 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc:     Shuah Khan <shuah@kernel.org>, pablo@netfilter.org, fw@strlen.de,
        linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: about selftests/netfilter test related issue
Message-ID: <20190401201607.ruzxt33qbxxn56ic@breakpoint.cc>
References: <CAG=yYw=VMJ5vK9aXcZ7AgC7f_dx+5ebKgwz68mV3=m6pOA_syA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYw=VMJ5vK9aXcZ7AgC7f_dx+5ebKgwz68mV3=m6pOA_syA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in> wrote:
> Error: Unknown device type.

Feel free to send a patch that makes it display a more reasonable
exit+error here.

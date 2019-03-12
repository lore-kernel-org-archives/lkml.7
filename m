Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EA2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2602147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfCLKbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:31:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLKbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:31:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE17681F09;
        Tue, 12 Mar 2019 10:31:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id BF64B272AB;
        Tue, 12 Mar 2019 10:31:34 +0000 (UTC)
Date:   Tue, 12 Mar 2019 11:31:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Misc improvements and bug fixes for perf
Message-ID: <20190312103133.GC13071@krava>
References: <20190311202446.10210-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 12 Mar 2019 10:31:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:24:36PM -0700, Andi Kleen wrote:
> Mostly unrelated to each other, so can be picked'n'chosed.
> 
> - Fix perf stat --no-scale
> - Support --reltime in perf script
> - Fix crashes with stat -r
> - Handle JITed code better in perf report
> - Allow to limit rotated perf.data files
> - Filter metrics in perf list
> - Show all sort keys in perf report help
> - Fix multiplexing formula
> 
> Also available in
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc perf/misc-fixes-4
> 

apart from the 2 comments it all looks good to me

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

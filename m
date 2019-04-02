Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E2CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A507204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfDBQQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:16:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52118 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729063AbfDBQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:16:13 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x32GFwbB026565
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Apr 2019 12:15:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AD2F3421A03; Tue,  2 Apr 2019 12:15:58 -0400 (EDT)
Date:   Tue, 2 Apr 2019 12:15:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jari Ruusu <jari.ruusu@gmail.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 file system livelock and file system corruption, 4.9.166
 stable kernel
Message-ID: <20190402161558.GA2781@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jari Ruusu <jari.ruusu@gmail.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
References: <CACMCwJ+qLHV+cjQC2kAnLQP6qVz1bJ75V8BqQBV5HE1edRC-AQ@mail.gmail.com>
 <20190402103507.GA15511@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402103507.GA15511@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 12:35:07PM +0200, Greg Kroah-Hartman wrote:
> So you need 5e86bdda4153 ("ext4: cleanup bh release code in
> ext4_ind_remove_space()") applied to all of the stable and LTS kernels
> at the moment (as that patch only showed up in 5.1-rc1)?
> 
> If so, I need an ack from the ext4 developers/maintainer to do so.

Acked-by: Theodore Ts'o <tytso@mit.edu>

						- Ted

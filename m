Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F258C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A57206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfHAL1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:27:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbfHAL1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:27:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F8B4AF8A;
        Thu,  1 Aug 2019 11:27:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 31557DA7D9; Thu,  1 Aug 2019 13:28:11 +0200 (CEST)
Date:   Thu, 1 Aug 2019 13:28:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        arnd@arndb.de, y2038@lists.linaro.org,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/20] fs: affs: Initialize filesystem timestamp ranges
Message-ID: <20190801112810.GR28208@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        arnd@arndb.de, y2038@lists.linaro.org,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-14-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730014924.2193-14-deepa.kernel@gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:49:17PM -0700, Deepa Dinamani wrote:
> Fill in the appropriate limits to avoid inconsistencies
> in the vfs cached inode times when timestamps are
> outside the permitted range.
> 
> Also fix timestamp calculation to avoid overflow
> while converting from days to seconds.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: dsterba@suse.com

Acked-by: David Sterba <dsterba@suse.com>

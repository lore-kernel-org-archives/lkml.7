Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC643C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB9521655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569349178;
	bh=OsaS1VYl9pObXZLL3BY3OATmyzBitb7H69LG7NkX9sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nyXCIjLUnDrLhYzYrP5+wO3JQuTuifk3YJvxf4+8P0OUn/yVadfSbBWpX0Nli4KGq
	 sIDs1FAzLtijRzTf5nzbGR4KCo3D8TWPbFaHgxccmJQCwCdXOuRtL4DBDTO/akBU5m
	 +mnKBNTBbO5Xl6fiZKv9AmrkREUJvQdctvgYwNzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394876AbfIXSTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394091AbfIXSTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:19:37 -0400
Received: from C02WT3WMHTD6.sdcorp.global.sandisk.com (rap-us.hgst.com [199.255.44.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E712A214DA;
        Tue, 24 Sep 2019 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569349177;
        bh=OsaS1VYl9pObXZLL3BY3OATmyzBitb7H69LG7NkX9sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FvoFpw9DjT8FpFiBNkrrT/4hNrcXZOGaxhA7sLSPlWWEYOKhkFLi7Z89tQFVejmTu
         bs7hXMTB9EK/MBz2SExGBgu++N9ONBoyR7501Y2L+wyUtgrGXvExO0jkgPWYZGOc88
         4viA+1LuO8E8PbdJoSHgL1s+8Ecn6/+hGKcpVibI=
Date:   Tue, 24 Sep 2019 11:19:35 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: allow 64-bit results in passthru commands
Message-ID: <20190924181935.GB30811@C02WT3WMHTD6.sdcorp.global.sandisk.com>
References: <786558932.78398145.1569330892814.JavaMail.zimbra@kalray.eu>
 <17936ba6-8f2c-370f-753b-fef8b531c810@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17936ba6-8f2c-370f-753b-fef8b531c810@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:05:36AM -0700, Sagi Grimberg wrote:
> Looks fine to me,
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Keith, Christoph?

Looks good to me, too.

Reviewed-by: Keith Busch <kbusch@kernel.org>

Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CBEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E8720857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552992537;
	bh=RmnpjTJ1E5QbNRia1ocIIZKNkc6GZPEMdfCXhtk/DPM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=tHKQjvJe32vszCEWhg9Zsb398HbKhSrz7sfrRvqELb5lgSGAw2UaDrRYCQQHwrBxQ
	 dVsKG1vk3Q2a3894L64xKtt8Icc/OGHdZMm1bCbrbj6SSEZxZhyaV3GwBCnOW60KSQ
	 wKYKOK0wfWiqlMUVFtvjajQKaclT/ZXrmT6Ux6UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCSKsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfCSKsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:48:55 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA75220857;
        Tue, 19 Mar 2019 10:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552992534;
        bh=RmnpjTJ1E5QbNRia1ocIIZKNkc6GZPEMdfCXhtk/DPM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=2nPB4OMg+kjVBTGhGLvuZw5EOTnAHhPRPEwLAaQqUVUuP9Tq7Z5KuCw5VjsZGOMok
         YlvTidKUTBWM1B2x6WR+IrH6sEDX4e+OvC+SRblzaN1BsSr0zgSpz1jodvVVrZ1b76
         e/RzDX0DQqzhs5awU+aJBIpfTT4ism3THcmSoSpE=
Date:   Tue, 19 Mar 2019 11:48:51 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
cc:     pakki001@umn.edu,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hid: logitech: check the return value of
 create_singlethread_workqueue
In-Reply-To: <20190314052402.31448-1-kjlu@umn.edu>
Message-ID: <nycvar.YFH.7.76.1903191148210.19912@cbobk.fhfr.pm>
References: <20190312100233.106098c8@lwn.net> <20190314052402.31448-1-kjlu@umn.edu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019, Kangjie Lu wrote:

> create_singlethread_workqueue may fail and return NULL. The fix
> checks if it is NULL to avoid NULL pointer dereference.
> Also, the fix moves the call of create_singlethread_workqueue
> earlier to avoid resource-release issues.
> 
> --
> V3: do not introduce memory leaks.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

The signoff has to be in the commit log, not in the "notes" area. I've 
fixed that and applied.

-- 
Jiri Kosina
SUSE Labs


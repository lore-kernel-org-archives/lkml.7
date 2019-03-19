Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3592133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552993195;
	bh=ovqFhIl8Wav12H/0A9w1/UhSD/IQTNxRcCh8i6YY9Lg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Eyw9BG56Yerg3HdY8SXjrk7UpBlNU21rRzo2v4UVhguIEPwlGZEVkeM6bNpLL1zdz
	 ucTh6W4979ZF6nt9YGGEkKQn6D45cLvgg9WjLSFGGm1zn3q29Z03wKXcRucg01raFR
	 N7cWtzkL3myhBE8oPmEoIdv311gFfmx5KYnfvMMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCSK7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfCSK7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:59:53 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE61920828;
        Tue, 19 Mar 2019 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552993192;
        bh=ovqFhIl8Wav12H/0A9w1/UhSD/IQTNxRcCh8i6YY9Lg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=u2m5dU2rDH452mfL4Gvh65wgQege1W32YgSBj9ZzKTc7dArn075jzOX9cgLcv4r0Z
         VQuOcdKSVgnoM4iNBKsfhjfhqbD+6AtMPse0G4R05FI7+FZvpNx7B5XiOkdP61rvLE
         /2MgOXWRxMiSgv6k4sSB7y+EhAxEZhag3l2CxVNQ=
Date:   Tue, 19 Mar 2019 11:59:49 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] HID: intel-ish-hid: Clean up external
 interfaces
In-Reply-To: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1903191158230.19912@cbobk.fhfr.pm>
References: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Srinivas Pandruvada wrote:

> NOT FOR kernel v5.1.
> 
> v2
> - Rebased on the top of
> "HID: intel-ish: enable raw interface to HID devices on ISH"
> which Jiri already applied.
> - Also exported devc pointer for DMA

I've already reviewed v1 before, so I just went through these highlighted 
changes above, and applied.

Thanks,

-- 
Jiri Kosina
SUSE Labs


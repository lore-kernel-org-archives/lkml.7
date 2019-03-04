Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3D721019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551680610;
	bh=QDgLZQIwBqtidFSd7jCjEPTBZeo7B5UUG/YAp74/y9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FRiNN0BogNTx0cVvFI022x31n/rKt+smHsAXoiBUElcDgTIgQfRD52Kbmi9ZX8uEx
	 Ktoe7zgxX8C9fsCq5vACEp/PqzHmlQGbpayurHxZAKHE444Zqhm97GzuvcNAyJHN6r
	 3KR3fk6Niv29zBU4dz370GUjGMt5QHyknerSDBes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfCDGX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfCDGX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:23:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0789A20815;
        Mon,  4 Mar 2019 06:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551680608;
        bh=QDgLZQIwBqtidFSd7jCjEPTBZeo7B5UUG/YAp74/y9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJ9vUjmvOzFxgz1RKIUZH4R9wdM2cKaWLBmEdoKFd2/AhJFHw9Rp3JB58MxpV4p+X
         b7QLdL0EW13dVlJKQyLrL4OPiDbtl1AswfZCWS1hZ+pBHj9mIVexWHKHR22vaRdCGC
         7UxlFhFIIbMpsjj4MIEJIZNwyLs8Twp3NgnDoR5Q=
Date:   Mon, 4 Mar 2019 07:23:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jacky.Cao@sony.com
Cc:     oneukum@suse.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub port
Message-ID: <20190304062325.GA2686@kroah.com>
References: <16EA1F625E922C43B00B9D8225022050086961B5@APYOKXMS108.ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16EA1F625E922C43B00B9D8225022050086961B5@APYOKXMS108.ap.sony.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 02:08:54AM +0000, Jacky.Cao@sony.com wrote:
> ________________________________
> 
> This email is confidential and intended only for the use of the individual or entity named above and may contain information that is privileged. If you are not the intended recipient, you are notified that any dissemination, distribution or copying of this email is strictly prohibited. If you have received this email in error, please notify us immediately by return email or telephone and destroy the original message. - This mail is sent via Sony Asia Pacific Mail Gateway..

This footer requires me to delete this email as it is not compatible
with doing Linux kernel development.

greg k-h

Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E22C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB44B21734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578040422;
	bh=rMSSUVmSOtKzyQpR+gRV2i4UIL+9avgFuwUKV2Xs8wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MnhxDfSAK+nWSZq6Nn0DhNzOXFyVulZiHNjfF9W+gvW0nIE6GdHqp68n/zb/qHonx
	 luDcJKue5UzIhNiO79u7PdozTFENXB6zMGVtiz8N7sJD7nMgJU1cDpRwu5oT0O5Umx
	 O9D12MeWdytMnTDfn79iBY1/MGDW7GmtMBZbl28I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgACIdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACIdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:33:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B284C20866;
        Fri,  3 Jan 2020 08:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578040421;
        bh=rMSSUVmSOtKzyQpR+gRV2i4UIL+9avgFuwUKV2Xs8wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQ7GddN/cGHTbzSN7EBHiIV+/UuFa8BXxHH7NWiktmcSnhEqJt5h6a5o2IaKDO5MU
         yLIXr10yrbxJqexDu4MdmODvOfMHhvUfBltI7jH2FfDqhh0jv+o/9Ox46MHmDmFRZQ
         ORQDXQb79RIML2cIASavbKrH5UBcPblkMU10jnjQ=
Date:   Fri, 3 Jan 2020 09:33:39 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Chester Lin <clin@suse.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joey Lee <JLee@suse.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [RFC PATCH v2 2/3] ACPI / hotplug: Eject status trace and
 auto-remove approach
Message-ID: <20200103083339.GA831558@kroah.com>
References: <20200103043926.31507-1-clin@suse.com>
 <20200103043926.31507-3-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103043926.31507-3-clin@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 04:40:13AM +0000, Chester Lin wrote:
> +	eject_node = (struct eject_data *)adev->eject_stat;

No need for this cast.

You do that all over this patch, it can be removed everywhere.

thanks,

greg k-h

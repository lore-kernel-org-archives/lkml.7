Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F824C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242D020705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578504760;
	bh=zde4+thehnGbArbgETmp1/n9EV2vs2E9tBvzdNLOWRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ft07vHLBO2VHAXbSlsxnjwKwInH2h+mGzdDM9avgIzzQvt7n0Dkx6ed9D7tt1XmqX
	 KtqVwjZWgMQ5Uto2bAX8/BLwq/9R+TaCVfThyfhbjRFwmUAkeUImpB+2ZLPLfLNS4v
	 SrlqxY7CExl0fHJWLW7iU5OlA3QwR/J5GehMr5r0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgAHRci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:32:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbgAHRci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:32:38 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23776206F0;
        Wed,  8 Jan 2020 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578504758;
        bh=zde4+thehnGbArbgETmp1/n9EV2vs2E9tBvzdNLOWRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Om03RYLZO25YvBd8fQ4l4lkiK29Fdgv+RsswocuPPdU8cVBbPL8UYGmspZ/Lmfhcc
         OgIaEtWTt9OeZi5x4j8z52DIU4qVrUQKDPTALpT1d+K7HPrn5S9FEzq3BPi0L7oq1H
         wysaixnizUdIlLmRtw+x2WC4PhaB8VUkHOm1YAVs=
Date:   Wed, 8 Jan 2020 17:32:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH v8 00/25] arm64: MMU enabled kexec relocation
Message-ID: <20200108173225.GA21242@willie-the-truck>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 10:59:13AM -0500, Pavel Tatashin wrote:
> Many changes compared to version 6, so I decided to send it out now.
> James Morse raised an important issue to which I do not have a solution
> yet. But would like to discuss it.

Thanks. In the meantime, I've queued the first 10 patches of the series
since they look like sensible cleanup, they've been reviewed and it saves
you from having to repost them when you make changes to the later stuff.

Will

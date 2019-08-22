Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AC4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54A422CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566483650;
	bh=8MqlUatSctkbqp+1Hg7nVyv4KXdjvXtOXlS6Wst43Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RFH5lsVGYotKzG05OVX/FCtPMMDdaV6Uwo2RfBBY2RZxUWjUzYeoKvK/iW18xCtn+
	 gEoVP6LI+93Bb886jVZPWRd7U0Dfu22e+/bvzIk280t8e61ZJtWusUVwjbAqWXjMlO
	 p17VTvMEigsPh2ncihLX5rEg9tNFkOv820Fhc56c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbfHVOUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730741AbfHVOUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:20:49 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361F621743;
        Thu, 22 Aug 2019 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566483648;
        bh=8MqlUatSctkbqp+1Hg7nVyv4KXdjvXtOXlS6Wst43Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujbU2O2jnyREorVwJ+WmmJw/KnqRSX/+CKahp8nRonFsSCWsbN8ZQxNNGJ9zFX8Rk
         rDb8oMraS0tKyXs5GgPLd3RY9Sqw3lHgFxNOBW4GkIx1EPdvAcCKm1a9EBHu5OHMWo
         7vmq5hzDsGAk7rWybUhVvM1EncJ5q/vZTx6nnmcE=
Date:   Thu, 22 Aug 2019 16:20:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 13/38] posix-cpu-timers: Simplify sample functions
Message-ID: <20190822142045.GQ22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.430475832@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.430475832@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:00PM +0200, Thomas Gleixner wrote:
> All callers hand in a valdiated clock id. Remove the return value which was
> unchecked in most places anyway.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

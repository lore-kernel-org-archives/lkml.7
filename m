Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41D5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88048233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566477041;
	bh=ahKZi1+AXtwqX3cogI5vAgJtQWrq4XQrFQxDGnNh/LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aq1Oh5pskP6kID1BkZYWmLG27/QBKLU4rHCHSEdi8y7MOMXm9YkVKJzto9H1MkYb6
	 ydhP6WZ614mQ6BnTL2GMnFXkWn2WEfpcCfkS0pK+r1Ixf9FgATDhHQXdQIji2DzpCd
	 RZ/xvEqQp4SW+snO4BbTaMttCgbnz0g2FWVpSbIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbfHVMak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbfHVMaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:30:39 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E0B9206BB;
        Thu, 22 Aug 2019 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566477039;
        bh=ahKZi1+AXtwqX3cogI5vAgJtQWrq4XQrFQxDGnNh/LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D27xi+3WiAAQUUNWj3tLyjnhXKZynfZFELokQqdltMU5dS68ZXsznN8y6R4mVL05G
         jHXF/NlM+Q0QWiOOTD9IJqArghiKfXPxy6dDA9EeKAg0a2YASsazkswhMazmY5yj1/
         Y4+uzcox6tuFqrSzeOtpFtjREWO7jUUlXIs6CjMw=
Date:   Thu, 22 Aug 2019 14:30:36 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 06/38] posix-cpu-timers: Sample directly in timer check
Message-ID: <20190822123036.GJ22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192919.780348088@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192919.780348088@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:53PM +0200, Thomas Gleixner wrote:
> The thread group accounting is active, otherwise the expiry function would
> not be running. Sample the thread group time directly.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

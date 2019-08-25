Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E676C41514
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 22:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F9A2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 22:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566772541;
	bh=fWYAPG+1006AeWWBWjdG72l6elL2X09zkjVtE8i+LMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mvdAtYB+UBUleLAyLw5s+4AcqLHf7FboWmy+9mtwoNdY8ZZ/EKZEUdCai8OfN+GFF
	 xUFcAbfg9NRMisYOTa5zqb4mIDudKfKDY29x2mJNrqnxQQnJCH0ovlKV8jwtmA1BWQ
	 TjlSVDN73sE9W4BExZgP5V9HzFDw9EyqhjPYWaIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfHYWfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 18:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbfHYWfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 18:35:40 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8942070B;
        Sun, 25 Aug 2019 22:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566772539;
        bh=fWYAPG+1006AeWWBWjdG72l6elL2X09zkjVtE8i+LMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pG5I1EzAHntwN3s4m3gHH+8/TIlRnVM79XmNAIeWYXWplYBB58l/xUs6H+05dt4J+
         XwS+Kv4zcbRXT6HXgyUm0ANczl6MpluKFQVQGaY7qzBGzGd2xtvheXcoDfCXxWI5JD
         Rb5Z4SErUlv2gPPlzL6m+NyWJ7KnHKZ59CnCW+Yg=
Date:   Sun, 25 Aug 2019 18:35:38 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     =?iso-8859-1?Q?J=F6rg-Volker?= Peetz <jvpeetz@web.de>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 5.2.10
Message-ID: <20190825223537.GB5281@sasha-vm>
References: <20190825144703.6518-1-sashal@kernel.org>
 <qju9bd$47qi$1@blaine.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qju9bd$47qi$1@blaine.gmane.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for looking into this!

On Sun, Aug 25, 2019 at 05:26:37PM +0200, Jörg-Volker Peetz wrote:
>Where can I find your public gpg key and it's fingerprint?
>It's not yet documented on https://www.kernel.org/category/signatures.html .

You're right, I'll send a patch to add my fingerprint as well.

>I'm asking because the "gpg --locate-keys" method does not work for me.

I can confirm this, and this is weird... I see a kernel.org UID on the
key, and gpg seems to confirm that as well:

$ gpg --quick-add-uid DEA66FF797772CDC 'Sasha Levin <sashal@kernel.org>'
gpg: Such a user ID already exists on this key!

Let me contact kernel.org support to see what I'm doing wrong...

--
Thanks,
Sasha

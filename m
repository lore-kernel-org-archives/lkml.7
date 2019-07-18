Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3328DC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E5021849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563478380;
	bh=CLupE/lo1riA13YdIygZu79G1Jn33wd0Lj+QWcC8hvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KY3SAotJDZumQrEW63dIm6nwRmiFky6dEu/loywI7ojmRpwKLn3ejQZLOsrSzj/ot
	 O//jH9C9FJwEpGQHA6AsIWGbZu/JkjXabfUwUnkqv2pGav0IqvF0ykQyjlCItPRt44
	 y8w3ZxnehXj+K8/Lf4qkOC7Zi2AsR3zyo4TT9OXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391412AbfGRTc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbfGRTc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:32:58 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B4B52173B;
        Thu, 18 Jul 2019 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563478377;
        bh=CLupE/lo1riA13YdIygZu79G1Jn33wd0Lj+QWcC8hvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0qY8XsM16uoNsDiGiFobZCQn9iZpIYq9m36toWJoC7Up2mKOVowQcCENm+yPX4TPM
         p5KIDd+GRV7eoJaCSNNeWk9ngTuznnyPM7n7wlqtwcJI+LQ2Vda8hg9E9qRN0Xxgqp
         XgcVGYebdLZuY5pxtbxZyVmcEMNSWZHS0nntRjfs=
Date:   Thu, 18 Jul 2019 15:32:56 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jiri Benc <jbenc@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH AUTOSEL 5.2 226/249] selftests: bpf: fix inlines in
 test_lwt_seg6local
Message-ID: <20190718193256.GA4240@sasha-vm>
References: <20190715134655.4076-1-sashal@kernel.org>
 <20190715134655.4076-226-sashal@kernel.org>
 <20190717114334.5556a14e@redhat.com>
 <20190717234757.GD3079@sasha-vm>
 <20190718093654.0a3426f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190718093654.0a3426f5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 09:36:54AM +0200, Jiri Benc wrote:
>On Wed, 17 Jul 2019 19:47:57 -0400, Sasha Levin wrote:
>> It fixes a bug, right?
>
>A bug in selftests. And quite likely, it probably happens only with
>some compiler versions.
>
>I don't think patches only touching tools/testing/selftests/ qualify
>for stable in general. They don't affect the end users.

I'd argue that a bug in your tests is just as (if not even more) worse
than a bug in the code.

--
Thanks,
Sasha

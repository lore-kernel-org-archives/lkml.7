Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37573C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A74214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b="XHRbRo+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfDWSCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:02:18 -0400
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:38048 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727656AbfDWSCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:02:17 -0400
Received: from resomta-po-14v.sys.comcast.net ([96.114.154.238])
        by resqmta-po-07v.sys.comcast.net with ESMTP
        id Iu18hQvFRe39RIzcOhmohk; Tue, 23 Apr 2019 17:54:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1556042048;
        bh=wLoOD2BS5wmOFNP8lws2IgHCrkaVnLD9UtDgXiFITwQ=;
        h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
         MIME-Version:Content-Type;
        b=XHRbRo+JzyrkhQ2/jVraA1yC5NQoEDqpgwwBDzoFZnWVnCi4acHAZoB7zk0QyDKjb
         kAgT9kUnY8iRSxZRFNfUi0p9u/divsevZ/6zA+wiQex8xVyZDOadQFE1V6lP1iuaI4
         vCF5VlZglNyqE82S9qZTrnNGONYkpsbk24YkdyAI093tryiX+L3OXv6fCRT4ZFw+Xz
         k9qSl0Su2KCAhgWoyBE8P3wNTB2at3nBY5Bd0ylnhAE7Hj3M0pWp1V07ShjzVhgQEQ
         LUG+cL+LSYPq0JS/A78FC7REu9RxiqCkFoL635c8VuOr00KQRAVi/1u1vM/eiMWFfg
         ochWI8XPfD9YA==
Received: from [IPv6:2001:558:6040:22:2171:426f:b27e:296d] ([IPv6:2001:558:6040:22:2171:426f:b27e:296d])
        by resomta-po-14v.sys.comcast.net with ESMTPSA
        id IzcNhmECDwpUAIzcOhcaMO; Tue, 23 Apr 2019 17:54:08 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Reply-To: james@nurealm.net
Subject: Re: [PATCH 2/2] HID: input: fix assignment of .value
To:     Sasha Levin <sashal@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190423154615.18257-2-benjamin.tissoires@redhat.com>
 <20190423172117.CC66520835@mail.kernel.org>
From:   James Feeney <james@nurealm.net>
Message-ID: <37009110-5a11-7ed4-3315-e87b98cc45b7@nurealm.net>
Date:   Tue, 23 Apr 2019 11:54:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423172117.CC66520835@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 11:21 AM, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 2dc702c991e3 HID: input: use the Resolution Multiplier for high-resolution scrolling.
> 
> The bot has tested the following trees: v5.0.9.
> 
> v5.0.9: Failed to apply! Possible dependencies:
>     724f54bc0063 ("HID: input: make sure the wheel high resolution multiplier is set")
> 
> 
> How should we proceed with this patch?
> 
> --
> Thanks,
> Sasha
> 

This patch will only apply *after* the application of the first patch, since they "overlap".

Yes, that is probably not the best circumstance.  I think Benjamin wanted to keep the issue in patch 2/2 distinct.

Was the first patch applied before attempting application of the second patch?

James

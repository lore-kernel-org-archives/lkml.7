Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB8AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B822077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b="CbAjzVK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfDXPmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:42:04 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:55750 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730163AbfDXPmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:42:03 -0400
Received: from resomta-po-13v.sys.comcast.net ([96.114.154.237])
        by resqmta-po-09v.sys.comcast.net with ESMTP
        id JGcYh0tjiNBGvJK26hAi09; Wed, 24 Apr 2019 15:42:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1556120522;
        bh=OsrM/Bsva4RwGFaT/nZgwNkE1/WhG8jGyH9iGznKOW0=;
        h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
         MIME-Version:Content-Type;
        b=CbAjzVK94alwDuI0g7sM8SUPI76SOOTtd6SHi9eDvOL5QYIV+g8Xg2qvhwULstT5y
         KSRSoryAYw7MrmClqF4tQDDLhSgV9naHlTrF4ZrpJ/uQ3DQE1eJ3rVMITeVPgIAjoH
         QUqKfxx9JzW+j/Gu2KHRF4MRs2dXYgwe2N4MQu9Lg/wQ6EYI7fWBpX0gOlWyoFYIMS
         XF2Q/AC/lxmpt38jWVgoJjUyhHOBSngw5Loqu4jQEEjGoQ6QgdYa1S/t2vMxK/5Xn+
         0EQjPDYAex4SlJ3Yx8KJaWWb1Nl62vmCjwvzk+iDihsWnoWi1u4gAO+B71Cty+dDSs
         /U6Nlv8LCE/CA==
Received: from [IPv6:2001:558:6040:22:2171:426f:b27e:296d] ([IPv6:2001:558:6040:22:2171:426f:b27e:296d])
        by resomta-po-13v.sys.comcast.net with ESMTPSA
        id JK25h1CBkM7ICJK26haAVB; Wed, 24 Apr 2019 15:42:02 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Reply-To: james@nurealm.net
Subject: Re: [PATCH 1/2] HID: input: make sure the wheel high resolution
 multiplier is set
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
References: <20190423154615.18257-1-benjamin.tissoires@redhat.com>
 <CAO-hwJLCL95pAzO9kco2jo2_uCV2=3f5OEf=P=AoB9EpEjFTAw@mail.gmail.com>
From:   James Feeney <james@nurealm.net>
Message-ID: <43a56e9b-6e44-76b7-efff-fa8996183fbc@nurealm.net>
Date:   Wed, 24 Apr 2019 09:42:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAO-hwJLCL95pAzO9kco2jo2_uCV2=3f5OEf=P=AoB9EpEjFTAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Benjamin

On 4/24/19 7:30 AM, Benjamin Tissoires wrote:
> Given that this basically breaks a basic functionality of many
> Microsoft mice, I went ahead and applied this series to
> for-5.1/upstream-fixes

Is there some reason that both patches should not be applied immediately, to the 5.0 series?

Or - likely I am uninformed - are the 5.1 patches applied as a set separate from the 5.0 series revisions?

Thanks
James

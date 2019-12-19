Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62996C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D22222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="CcoAQ8RP";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="CcoAQ8RP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfLSVSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:18:03 -0500
Received: from node.akkea.ca ([192.155.83.177]:35702 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfLSVSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:18:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 61CDB4E2006;
        Thu, 19 Dec 2019 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576790282; bh=OFvkXpgSlnb0/pUde8cMlEl0cLNJVrFCr4s08Ho54bQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=CcoAQ8RPcCBtfw7CpmT+5ehRWvIo07gAA5GsrhmxS4lEoacb9JvZNlJ7Hgrar3uPs
         XMCWZ/8rcendV4xcx6LTmFMfuDbBn5Sjcc+Ep9TFmyTDXQVYIJ9zCgXTtevZjf7Q8W
         CRjLEe8tw7Q0/M2PBJqTULSpJSNd/8qCti0Vef6I=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WS9QXKpTBfZG; Thu, 19 Dec 2019 21:18:02 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id 095444E2003;
        Thu, 19 Dec 2019 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576790282; bh=OFvkXpgSlnb0/pUde8cMlEl0cLNJVrFCr4s08Ho54bQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=CcoAQ8RPcCBtfw7CpmT+5ehRWvIo07gAA5GsrhmxS4lEoacb9JvZNlJ7Hgrar3uPs
         XMCWZ/8rcendV4xcx6LTmFMfuDbBn5Sjcc+Ep9TFmyTDXQVYIJ9zCgXTtevZjf7Q8W
         CRjLEe8tw7Q0/M2PBJqTULSpJSNd/8qCti0Vef6I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Dec 2019 13:18:02 -0800
From:   Angus Ainslie <angus@akkea.ca>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     krzk@kernel.org, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH v2 0/2] Add MAX17055 fuel guage
In-Reply-To: <20191219001531.gnav4roprttdwknc@earth.universe>
References: <20191214152755.25138-1-angus@akkea.ca>
 <20191219001531.gnav4roprttdwknc@earth.universe>
Message-ID: <cb3c9effe0995d2cd7b48ef4a9c6ae03@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-18 16:15, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Dec 14, 2019 at 07:27:53AM -0800, Angus Ainslie (Purism) wrote:
>> Extend the max17042_battery driver to include the MAX17055.
> 
> Thanks, queued to power-suply's for-next branch.
> 
> -- Sebastian
> 

Thanks

Angus

>> 
>> Changes since v1:
>> 
>> Change blacklist driver checks to whitelists.
>> 
>> Angus Ainslie (Purism) (2):
>>   power: supply: max17042: add MAX17055 support
>>   device-tree: bindings: max17042_battery: add all of the compatible
>>     strings
>> 
>>  .../power/supply/max17042_battery.txt         |  6 ++-
>>  drivers/power/supply/max17042_battery.c       | 17 +++++--
>>  include/linux/power/max17042_battery.h        | 48 
>> ++++++++++++++++++-
>>  3 files changed, 66 insertions(+), 5 deletions(-)
>> 
>> --
>> 2.17.1
>> 

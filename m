Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D82AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 01:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE08521902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 01:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="hTj2wSti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfCWB0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:26:16 -0400
Received: from sonic306-21.consmr.mail.gq1.yahoo.com ([98.137.68.84]:42137
        "EHLO sonic306-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727611AbfCWB0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 21:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1553304372; bh=0g9Ba86D2mKmmE2Z+VCcVi0g5RS36hnNjY8TZvUm4Ss=; h=In-Reply-To:References:To:From:Cc:Subject:Date:From:Subject; b=hTj2wStiLlZGvDYV2Ix7So9MxsX7p6/q1A/haeQ4G6kMPa40Vu54W2DBvtZ8vt9Z8vbHqq01I03s4p2awTlCaYjfvzYMDiEbwpCZoSM812PXisMVWSFcvNvxAZTo06ztL8HKlYIZrEM0juVB5dWFInwe7aOpWu8KUcmk5uC1SkVT5Mn+lTM9DF0gvlH2X1cDCtlNnqTNd02g9BIh2BrSm2go2/T0j/XcrfwzG+T71ZxTVc4M7t4QXl1KfQ4v/VkZf9E783zoFA6JDnPh8DcxHy9k76+S9q4+Ch9gY+V+cAx0bBLXElXgPUrJpuxutfuwBI1aqzSS/r6pJcGnU7zdtA==
X-YMail-OSG: y8ghO1AVM1lquEtjhH9vpFtOcuCM2Jn2rvCN52UyoClTik_0lfvMfM5KdK6VYMI
 nbbUjtLm3jRaYsXfm1hohKQSbkKcAAmQR05b_ykaW3IAXROPZYSi8TFMUqMA_cFDkIBm9j5OfLC7
 rpAArvdfSyhbF7B52D1UCZRfMhhhDFo3BFzM4vj2VdkCTXfpMeYPOLtVBv8rrD6o6GpFAM1oDR2z
 JXyZ8iG7T9V77NhZptDHcafAnCKQuBnVj3IMigcPgKxvRSwnFwManFQpu_Rj_HoBlXjDpRGyGs6E
 baTxt_Ae9tBD1pqZwWiS6z9yq4SQSuTau_dVaHIyEgKIMCWTvGdRGQXM_jSRyJXiDA36EFdpMbNM
 FW8rAVXg_n7HZBCyqgygXBqq.HEfjF5BaXiwW6pJM07tSmU4Os65IWIBylvEyrI87D491Xcctxcq
 y8XeckBjsjrVKiPyK0wOwN2JjoAd1.4JuRt9qn5IWpm1ofN88hPgeXnsyfHPSqMLcT57GotpIxUQ
 SPUslAxy1K.G8KMkpb0IiTlbLo.jq_cjoPGs04JZiGBZp.42us2pE9v0xDWnxSxqcvWRPVCE4IqV
 dawX6c87Er_lbMprHNILhlR9Ag3I.CuxClcaRpGMGejabHkWBVrDVIyJ3Z7ZH5x3dFkshUmL0Tqc
 tenwqdxk6VRYuMiExXWWBgfvyuOHvtjwd9dHV5YDYbQTI7DiqR3CeBEmtlC6RpAiOrW6._Z9D5VQ
 B0osbn1.aQbRrgHlNiyGTAR95gK3k5MeaEBf49QidLXfRzQmEgi3RYex8aitRnt1OuJV.978pl13
 O242LgBDeh6N2A9gXVop85BhFcOI1zOIyTlnWEr0dHXBt7QxI6slwRRBEzXNGevcTsyxgT4fe67m
 giFpQ_FiBpPvCpSwaLtvqURhrDZP_CsSmVDFKxiUp7ZYy2r04rSAFDDV6dbCAHU0tZyTBanMxgZp
 XXIIS9qAV3RSN5Tw7YvLxomwcuorCwfHQej7bF0MolR8yzChgug7CjzQpcdW8ERS09jI19rYauj4
 yZ_icWRPBWK_F7BPzRUWAPLPdIJUF_webICQI8VYdwcuoSU9S7R.J
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sat, 23 Mar 2019 01:26:12 +0000
Received: from pink.alxu.ca (EHLO localhost) ([198.98.62.56])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b147dedcb096429b486a3246b29a56d9;
          Sat, 23 Mar 2019 01:26:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none>
References: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
From:   Alex Xu <alex_y_xu@yahoo.ca>
Cc:     gnomes@lxorguk.ukuu.org.uk
Subject: Re: r8169 only works in promisc mode
Message-ID: <155330437093.30436.14334194918440470993@pink.alxu.ca>
User-Agent: alot/0.8.1
Date:   Sat, 23 Mar 2019 01:26:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have done some more investigation, some of which I posted on the
Bugzilla bug.

I believe the promisc issue is due to the MAC address receive filter
being silently reset to the invalid burned-in address. I used wireshark
and determined that the outgoing MAC address after suspend is the
overridden value. Re-setting the overridden value with "ip link set eth0
address" appears to have no effect. Setting it to a different overridden
value works normally and resolves the packet loss issue. Removing the
module and re-inserting it also resolves the issue.

I also attempted to determine why the MAC address on boot is
8e:00:00:00:8e:8e. As far as I can tell, this value is burned into the
flash somewhere. I tried turning off the machine, unplugging the power,
pressing the power button several times, then plugging it back in and
immediately booting into Windows; the incorrect MAC address was shown.

This reminded me that I am experiencing another firmware-related issue,
namely that it appears that the machine is only able to reach S1 or
possibly S2 sleep mode, even when specifying S3, and even in Windows. I
think there may be some flash bitrot, but clearing the firmware
settings, by all of: in the interface, removing the battery, and setting
the jumper; had no effect. I also tried reinstalling the BIOS using the
vendor-provided Windows updater, which also had no effect.

In conclusion: I think my firmware is broken (even moreso than regular
PC firmware), but I believe there is in fact some bug with r8169 on
"RTL8211B" in 5.0-rc1.

I can try bisecting if someone more competent than me believes that
would be helpful.

Thanks,
Alex.

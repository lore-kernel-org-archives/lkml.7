Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA01CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2E42173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Qa9lMlG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbfHZOCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:02:06 -0400
Received: from mout.web.de ([212.227.17.12]:56473 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730327AbfHZOCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566828121;
        bh=Qv3uyLd2KlSZy39uaz7mOwlYiQyqmI4dnV5Xs9vVO0s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Qa9lMlG1GFv0PCJgRXCgNoXTnrSD8YCvDCe2/0vQE/eLKR2secbRErCnIuNM42fV6
         mc7Pba/N45Jgy3TuX11GsLDgEVC1So8HKRN4VGw9XlNoci+4COdgz8klnIMrAOdMIv
         ii8jNOw/VYLqdoGE6l9Bhb+5zjrL9RtYx2ZXl9KU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from uruz.dynato.kyma ([84.175.169.160]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZUS9-1hnc1s2hqP-00LEkz; Mon, 26
 Aug 2019 16:02:01 +0200
Received: from [127.0.0.1]
        by uruz.dynato.kyma with esmtp (Exim 4.92.1)
        (envelope-from <jvpeetz@web.de>)
        id 1i2FZJ-0007KO-2s; Mon, 26 Aug 2019 16:02:01 +0200
Subject: Re: Linux 5.2.10
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.stable
References: <20190825144703.6518-1-sashal@kernel.org>
 <qju9bd$47qi$1@blaine.gmane.org> <20190825223537.GB5281@sasha-vm>
 <20190826043328.GB26547@kroah.com>
From:   =?UTF-8?Q?J=c3=b6rg-Volker_Peetz?= <jvpeetz@web.de>
Message-ID: <8e4c772e-c0b7-c2d4-9301-67702c003dff@web.de>
Date:   Mon, 26 Aug 2019 16:02:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190826043328.GB26547@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE-frami
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+AtXaQBOwKNtzJWH6tZACFlGzX6yhAEdC/nJZFXmXwiqgNtCXJ1
 dwiLy3jlvwbFbSSO0eUmmmhzWbRFoJfpPrJYEX0QQYn9X/RtOfwMN6+BjdHH9Ytx2nOo0Fp
 WF0pNqNCFX9x2Xhd1gjQnhg8q8awCLNg2vZG0d2PNGT6hNzkqyWDJSpG5notpCnm3K5Ov7m
 fCEIF+iTN/oivrCnQvbBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uT9DTtUComE=:YBmWyZVI4JavBpioix348J
 yz+CmNP7Nn60Izfog8gX4ckm32k2nUJzddMTgpSr00q4wMb5WtmBaRRgzJi6SixI6+IntHWwl
 0kr9DF2/5Mix9ncwNj/7icefSYMZoXE97vUK35Y1uTp3Lvl3dpBTBSBqS8pbq0SKGaQVDzz0l
 RaTEWg4OLyHwu40YHNCaCgkkQ3xBUdWjeSRO2MoN1I3qQsE50zg/xlUoI4NPY6yRft/uwswfc
 rGNV4Z6xImvFzLDFmibXw87rdQqWiT7ZNyaxAwINChYxU05iWpKi4a2IjDjuOAhJT4Dud7ffy
 rdZAaotlXF3/6+eqpEBVMK1TXCFx58xkofyvjuDfMngq2kf558kqG7F/qASPrl2rVhgDUvpq6
 siNfoVZ8WeMHOBoZ530Ewh3tUJMB4t+ZTqfiTtC1xV0LW/WWNQMnlViziny6Pc3VJChxKxXOa
 Id6/857E+x08euSmTiXCx5oEnMbSnaPtsH6SHLMoMQDNsNcDkqWognpOqb0etU18nV0hW21Qa
 BvZ1gS8kCvmkyzWcb2AqlzmgHfTMBDUkGklvoPNKTAAh5zMf1DdGbnBGSu36T+Owu1UwTBzFi
 xiAdEDRJC0/m7VJ5iJepKjShUJSSMC5Z04uwU2nJ3WoWJaKRUW1W1fuBHGwUHQSPL2dlG66Sv
 kx1UKpZwnL0qoS4HXHucXLN+S3yHSjEu2qIfKhuLJJur+4jNy7dU8/gokR6kKpMlJy7ATDFea
 1LcpjDNsHAELDLTpCe6OY1hCbu+g/JhsB6DlGNV2cS+BscnGlQ+SukscLvDWAn4rIiHT3lqb7
 fpQW9dLJGglJ/Tl5GDWtsstUO3KGEhPsNywqGIIk8/AfVMEy3Pi7v25dOS68tzWXA1iV1yVQh
 DL+imRqBgyt7iE0w+gaJWfnPL19NeT2qVLtck7b8PhtLChobGff2OHiR7cOk7AeTaNVT/tZa+
 YkRXcMhA4fXqt0btudi+M2Z4XUvmnEM71PeN0PmIPVpr9uAtthCeV2J7l4JzO63tH25D/CHw4
 SIzfmezcar4De/lgJ0xp2v/6soxdMx4zYADkZCo9TkLAFTU4c8EzliMb1w/KcF1gDlRMlT0Nj
 iZnCV3uCwq4YQ+9ySzC1VZMsmg+/jEVJ1BagMk4eNe2ijvkEPU5TNfFmAWNqDR9SqPbGhft2p
 Cspis=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For me the command

$ gpg --receive-keys DEA66FF797772CDC

did the key import and I was able to verify the signature via
https://www.kernel.org/category/signatures.html
and then the git tag v5.2.10.

Thank you both very much.

Best regards,
J=C3=B6rg.

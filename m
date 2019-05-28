Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9AFC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBDE208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfE1JQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:16:14 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:55099 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbfE1JQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:16:14 -0400
Received: from [IPv6:2001:983:e9a7:1:10b2:2e62:e4b1:bd13] ([IPv6:2001:983:e9a7:1:10b2:2e62:e4b1:bd13])
        by smtp-cloud9.xs4all.net with ESMTPA
        id VYDLhh7WDsDWyVYDMhcQrR; Tue, 28 May 2019 11:16:12 +0200
Subject: Re: [RFCv1 07/12] media: mtk-vcodec: abstract firmware interface
To:     Alexandre Courbot <acourbot@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190528055635.12109-1-acourbot@chromium.org>
 <20190528055635.12109-8-acourbot@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <b4320740-a016-4a0e-b9ae-e042fd305b12@xs4all.nl>
Date:   Tue, 28 May 2019 11:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528055635.12109-8-acourbot@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHQtOX5MADbrSc0BgR3Xf4uWHabvx/iNsQfFjPfE1Hf9KtO+FwUZN9IsdsogUKl6uB7HAuflCzsZ3lukkMA0xM4v976x9GK4kn5ZkOCn2KflZQjmqe6N
 t9aZc5owBO9OFgzn2FvpSVErPNkgx3dBFKtjxg4QcQ0hiMKQ5zAlAsDNXpwja9aOG9iq8kXlQc0Il1NXLyHuDjNobyi4w44pall/sd8cciHEdRqbI64Q8Fpd
 1DpnKdVTuH7mWd25wXMObFc+eLQ/iqIFyA+JptP0h6ZI+sQcv47lLsxTLxAtEXxM8lPGbJCos5fLIN0QydR1vSYScr4qNxVwxdirIO2pArsRdPhQjZb1UgPg
 f92vGuWQi5naaIqboo45SRDEO69J21avyhJjd9VprAfVMpb3F7lEkYPt7Fr7eJ8T4lvofRYhVTucYQklvWhSF+z128KPPAu+iFKJDISsHkpRciZjVoovNJjN
 C0YmXMtHZapVfZ5+aHTVIZ5zxZ9P0xGpIclS5wECvZnrp6xHxBlL6eCBTcZvzzlQZehFOeyE2gsu2fpy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 7:56 AM, Alexandre Courbot wrote:
> From: Yunfei Dong <yunfei.dong@mediatek.com>
> 
> MT8183's codec firwmare is run by a different remote processor from
> MT8173. While the firmware interface is basically the same, the way to
> invoke it differs. Abstract all firmware calls under a layer that will
> allow us to handle both firmware types transparently.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> [acourbot: refactor, cleanup and split]

High-level question: is the mt8183 firmware different from the MT8173?
And if so, is or will that firmware be part of linux-firmware?

Regards,

	Hans

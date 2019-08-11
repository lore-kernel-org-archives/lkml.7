Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F77C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 01:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5615320880
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 01:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHKBDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 21:03:14 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:44163 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726292AbfHKBDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 21:03:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5F5DA1822563C;
        Sun, 11 Aug 2019 01:03:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: town85_38e2295c5af30
X-Filterd-Recvd-Size: 2035
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun, 11 Aug 2019 01:03:10 +0000 (UTC)
Message-ID: <67dd4fe22f197700a7bc3b663a63383ce51346df.camel@perches.com>
Subject: Re: [PATCH] dpaa2-ethsw: move the DPAA2 Ethernet Switch driver out
 of staging
From:   Joe Perches <joe@perches.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Date:   Sat, 10 Aug 2019 18:03:09 -0700
In-Reply-To: <VI1PR0402MB2800FF2E5C4DE24B25E7D843E0D10@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1565366213-20063-1-git-send-email-ioana.ciornei@nxp.com>
         <20190809190459.GW27917@lunn.ch>
         <VI1PR0402MB2800FF2E5C4DE24B25E7D843E0D10@VI1PR0402MB2800.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-10 at 21:45 +0000, Ioana Ciornei wrote:
> On 8/9/19 10:05 PM, Andrew Lunn wrote:
[]
>  >> +static int
>  >> +ethsw_get_link_ksettings(struct net_device *netdev,
>  >> +			 struct ethtool_link_ksettings *link_ksettings)
>  >> +{
>  >> +	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
>  >> +	struct dpsw_link_state state = {0};
>  >> +	int err = 0;
>  >> +
>  >> +	err = dpsw_if_get_link_state(port_priv->ethsw_data->mc_io, 0,
>  >> +				     port_priv->ethsw_data->dpsw_handle,
>  >> +				     port_priv->idx,
>  >> +				     &state);
>  >> +	if (err) {
>  >> +		netdev_err(netdev, "ERROR %d getting link state", err);

trivia:  Do please add terminating '\n's to all the formats.



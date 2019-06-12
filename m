Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81368C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF2E2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K0s48gVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406162AbfFLHjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:39:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48528 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbfFLHjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:39:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C7d5Ha095716;
        Wed, 12 Jun 2019 07:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=As3rSRodBmhvXpmKU3bKOUx22NatiWkZ+Xl8vHvw2I0=;
 b=K0s48gVkXLccDgvtGOO1pRgDasSUhz/2p8XTi5OZfTjQK+SPko5B+83baAsqyqm+aDyp
 3dcsXVIwvH8FtNoa3Wb3Ki8yzaHhhDB02clxn87nazwG8SyyMEV86jUJd93Mru60iXz4
 3nOtaLg00NcuxGp4rYp10RWMv9UQMHRww8P8jGbG721i3+upFUkZUeczXNz7Q34nePJd
 QfgCqskvhEaYhVCxeTVh96h72S5vlooV7G00NKzkHvyrWKz/F8cwJn5ar/pQjApT4lLN
 /tIqbAILQB00D4LTC4hJgYeNs4bc9vhW2gTXKCjA9YiZdCc2z7yCDjnBpQiRvq3wr7cJ 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t05nqsju4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 07:39:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C7ctEZ168459;
        Wed, 12 Jun 2019 07:39:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t04hysmur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 07:39:46 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5C7diLb023411;
        Wed, 12 Jun 2019 07:39:44 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 00:39:43 -0700
Date:   Wed, 12 Jun 2019 10:39:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: kpc2000: remove unnecessary comments in
 kp2000_pcie_probe
Message-ID: <20190612073936.GD1915@kadam>
References: <20190610200535.31820-1-simon@nikanor.nu>
 <20190610200535.31820-3-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190610200535.31820-3-simon@nikanor.nu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:05:35PM +0200, Simon Sandström wrote:
> @@ -349,9 +340,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
>  		goto err_remove_ida;
>  	}
>  
> -	/*
> -	 * Step 4: Setup the Register BAR
> -	 */
> +	// Setup the Register BAR

Greg, are we moving the C++ style comments?  Linus is fine with them.  I
don't like them but whatever...

>  	reg_bar_phys_addr = pci_resource_start(pcard->pdev, REG_BAR);
>  	reg_bar_phys_len = pci_resource_len(pcard->pdev, REG_BAR);
>  

regards,
dan carpenter
